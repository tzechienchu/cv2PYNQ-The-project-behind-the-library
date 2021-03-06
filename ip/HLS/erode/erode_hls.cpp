#include "erode_hls.h"

void erode_hls(wide_stream* in_stream, wide_stream* out_stream, int rows, int cols, int channels, int mode){
#pragma HLS INTERFACE axis port=in_stream  bundle=INPUT
#pragma HLS INTERFACE axis port=out_stream bundle=OUTPUT

#pragma HLS INTERFACE s_axilite port=rows bundle=CONTROL_BUS offset=0x14 clock=AXI_LITE_clk
#pragma HLS INTERFACE s_axilite port=cols bundle=CONTROL_BUS offset=0x1C clock=AXI_LITE_clk
#pragma HLS INTERFACE s_axilite port=channels bundle=CONTROL_BUS offset=0x24 clock=AXI_LITE_clk
#pragma HLS INTERFACE s_axilite port=mode bundle=CONTROL_BUS offset=0x2C clock=AXI_LITE_clk
#pragma HLS INTERFACE s_axilite port=return bundle=CONTROL_BUS clock=AXI_LITE_clk

#pragma HLS INTERFACE ap_stable port=rows
#pragma HLS INTERFACE ap_stable port=cols
#pragma HLS INTERFACE ap_stable port=channels
#pragma HLS INTERFACE ap_stable port=mode

#pragma HLS dataflow

	GRAY_IMAGE g_img_0(rows,cols);
	GRAY_IMAGE g_img_1(rows,cols);

	const int col_packets = cols*channels/4;
	const int packets = col_packets*rows;
	const int pixel_cnt = rows*cols;

	for(int r = 0; r < packets; r++){
#pragma HLS pipeline II=4
		ap_uint<32> dat = in_stream->data;
		g_img_0.write(GRAY_PIXEL(dat.range(7,0)));
		g_img_0.write(GRAY_PIXEL(dat.range(15,8)));
		g_img_0.write(GRAY_PIXEL(dat.range(23,16)));
		g_img_0.write(GRAY_PIXEL(dat.range(31,24)));
		++in_stream;
	}

	const int kernel_size = 3;
	hls::Size_<int> k_size(kernel_size,kernel_size);
	hls::Window<kernel_size,kernel_size,ap_int<8> >	kernel;
	hls::Point_<int> anchor (-1,-1);
	switch(mode){
		case hls::MORPH_CROSS:
			kernel.val[0][0]= 0; kernel.val[0][1]= 1; kernel.val[0][2]= 0;
			kernel.val[1][0]= 1; kernel.val[1][1]= 1; kernel.val[1][2]= 1;
			kernel.val[2][0]= 0; kernel.val[2][1]= 1; kernel.val[2][2]= 0;
			//hls::getStructuringElement(hls::MORPH_CROSS, k_size, anchor, kernel);
			break;
		case hls::MORPH_ELLIPSE:
			kernel.val[0][0]= 0; kernel.val[0][1]= 1; kernel.val[0][2]= 0;
			kernel.val[1][0]= 1; kernel.val[1][1]= 1; kernel.val[1][2]= 1;
			kernel.val[2][0]= 0; kernel.val[2][1]= 1; kernel.val[2][2]= 0;
			//hls::getStructuringElement(hls::MORPH_ELLIPSE, k_size, anchor, kernel);
			break;
		default: //hls::MORPH_RECT
			kernel.val[0][0]= 1; kernel.val[0][1]= 1; kernel.val[0][2]= 1;
			kernel.val[1][0]= 1; kernel.val[1][1]= 1; kernel.val[1][2]= 1;
			kernel.val[2][0]= 1; kernel.val[2][1]= 1; kernel.val[2][2]= 1;
			//hls::getStructuringElement(hls::MORPH_RECT, k_size, anchor, kernel);
			break;
	}


	hls::filter_opr<hls::erode_kernel, hls::BORDER_REPLICATE>::filter(g_img_0,g_img_1,kernel,anchor,rows,cols);
	//hls::Erode(g_img_0, g_img_1);
	//hls::Erode<hls::MORPH_RECT,1>(g_img_0, g_img_1,kernel);

	for(int r = 0; r < rows; r++){
#pragma HLS pipeline II=4
		for(int c = 0; c < col_packets; c++){
			ap_uint<32> dat;
			dat.range(7,0) = g_img_1.read().val[0];
			dat.range(15,8) = g_img_1.read().val[0];
			dat.range(23,16) = g_img_1.read().val[0];
			dat.range(31,24) = g_img_1.read().val[0];
			out_stream->data = dat;
			out_stream->user = (r == 0 && c == 0)? 1: 0;
			out_stream->last = (r == rows-1 && c == col_packets-1)? 1: 0;
			++out_stream;
		}
	}
}
