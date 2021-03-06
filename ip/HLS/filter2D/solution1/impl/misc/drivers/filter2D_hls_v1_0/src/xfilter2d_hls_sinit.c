// ==============================================================
// File generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
// Version: 2017.4
// Copyright (C) 1986-2017 Xilinx, Inc. All Rights Reserved.
// 
// ==============================================================

#ifndef __linux__

#include "xstatus.h"
#include "xparameters.h"
#include "xfilter2d_hls.h"

extern XFilter2d_hls_Config XFilter2d_hls_ConfigTable[];

XFilter2d_hls_Config *XFilter2d_hls_LookupConfig(u16 DeviceId) {
	XFilter2d_hls_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XFILTER2D_HLS_NUM_INSTANCES; Index++) {
		if (XFilter2d_hls_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XFilter2d_hls_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XFilter2d_hls_Initialize(XFilter2d_hls *InstancePtr, u16 DeviceId) {
	XFilter2d_hls_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XFilter2d_hls_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XFilter2d_hls_CfgInitialize(InstancePtr, ConfigPtr);
}

#endif

