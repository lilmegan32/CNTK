//
// Copyright (c) Microsoft. All rights reserved.
// Licensed under the MIT license. See LICENSE.md file in the project root for full license information.
//
// cntk_java.i -- SWIG Interface file for Java
//

//JNI defines UNUSED macro as well, undefining it so it doesn't conflict with CNTK's
%{
#undef UNUSED
%}

%include "CNTKManagedCommon.i"

// %include "managed_languages/header.i"
// %include "managed_languages/shared_ptrs.i"
// %include "managed_languages/templates.i"
// %include "managed_languages/defines.i"
// %include "managed_languages/ignores.i"
// %include "managed_languages/array_mappings.i"
// %include "CNTK_ExceptionHandling.i"
// %include "managed_languages/class_directives/DeviceDescriptor.i"
// %include "managed_languages/class_directives/Axis.i"
// %include "managed_languages/class_directives/Function.i"

// Customize type mapping for modelBuffer, used by Load
// template taken from various.i
// %apply char* INPUT { char* modelBuffer }
// %typemap(jni) (char* modelBuffer) "jbyteArray"
// %typemap(jtype) (char* modelBuffer) "byte[]"
// %typemap(jstype) (char* modelBuffer) "byte[]"
// %typemap(in) (char* modelBuffer) {
//   $1 = (char *) JCALL2(GetByteArrayElements, jenv, $input, 0); 
//
// }

// %typemap(argout) (char* modelBuffer) {
//  JCALL3(ReleaseByteArrayElements, jenv, $input, (jbyte *) $1, 0);
//}

// %typemap(javain) (char* modelBuffer) "$javainput"

/* Prevent default freearg typemap from being used */
// %typemap(freearg) (char* modelBuffer) ""

// %include "managed_languages/class_directives/Variable.i"
// %include "managed_languages/class_directives/NDShape.i"
// %include "managed_languages/class_directives/NDMask.i"
// %include "managed_languages/class_directives/Value.i"
// %include "managed_languages/class_directives/NDArrayView.i"


%typemap(javacode) CNTK::DeviceDescriptor %{

    public java.util.ArrayList<DeviceDescriptor> getAllDevices() {
        DeviceDescriptorVector devices = GetAllDevices();
        java.util.ArrayList<DeviceDescriptor> ret = new java.util.ArrayList<DeviceDescriptor>((int)devices.size());
        for (int i = 0; i < devices.size(); ++i){
            ret.add(devices.get(i));
        }
        return ret;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null) return false;
        DeviceDescriptor p = (DeviceDescriptor)o;
        if (p == null) return false;
        return CNTKLib.AreEqualDeviceDescriptor(this, p);
    }

    public boolean equals(DeviceDescriptor p) {
        if (p == null) return false;
        return CNTKLib.AreEqualDeviceDescriptor(this, p);
    }

    @Override
    public int hashCode() {
        return GetDeviceType().hashCode();
    }

%}


%typemap(javacode) CNTK::Axis %{

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null) return false;
        Axis p = (Axis)o;
        if (p == null) return false;
        return CNTKLib.AreEqualAxis(this, p);
    }

    public boolean equals(Axis p) {
        if (p == null) return false;
        return CNTKLib.AreEqualAxis(this, p);
    }

    @Override
    public int hashCode() {
        if (this.IsDynamicAxis()) {
            return GetName().hashCode();
        } else {
            return this.StaticAxisIndex();
        }
    }
%}


%typemap(javacode) CNTK::Function %{

    public static Function Load(byte[] modelBuffer, DeviceDescriptor computeDevice)
    {
        return Load(modelBuffer, (long)modelBuffer.length, computeDevice);
    }

    // TODO: look at C# implementation and make it look more like that
    private VariableVector argumentVector;
    private VariableVector outputVector;
    private java.util.ArrayList<Variable> argumentList;
    private java.util.ArrayList<Variable> outputList;

    private UnorderedMapVariableValuePtr outMap = new UnorderedMapVariableValuePtr();

    public java.util.ArrayList<Variable> getOutputs() {
        if (outputVector == null) {
            outputVector = GetOutputs();
            outputList = new java.util.ArrayList<Variable>((int)outputVector.size());
            for (int i = 0; i < outputVector.size(); ++i){
                outputList.add(outputVector.get(i));
            }
        }
        return outputList;
    }


    public java.util.ArrayList<Variable> getArguments() {
        if (argumentVector == null) {
            argumentVector = GetArguments();
            argumentList = new java.util.ArrayList<Variable>((int)argumentVector.size());
            for (int i = 0; i < argumentVector.size(); ++i){
                argumentList.add(argumentVector.get(i));
            }
        }
        return argumentList;
    }

    public static Function Combine(java.util.ArrayList<Variable> outputVariable) {
        VariableVector varVect = new VariableVector();
        for (int i = 0; i < outputVariable.size(); ++i)
        {
            varVect.add(varVect.get(i));
        }
        return CNTKLib.Combine(varVect);
    }

%}


%typemap(javacode) CNTK::Variable %{

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null) return false;
        Variable p = (Variable)o;
        if (p == null) return false;
        return CNTKLib.AreEqualVariable(this, p);
    }

    public boolean equals(Variable p) {
        if (p == null) return false;
        return CNTKLib.AreEqualVariable(this, p);
    }

    @Override
    public int hashCode() {
        return (int)GetHashValue();
    }

%}

%typemap(javacode) CNTK::NDShape %{

    public java.util.ArrayList<Long> getDimensions(){
        java.util.ArrayList<Long> ret = new java.util.ArrayList<Long>((int)GetRank());
        for (int i = 0; i < GetDimensions().size(); ++i ) {
            ret.add((Long)GetDimensions().get(i));
        }
        return ret;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null) return false;
        NDShape p = (NDShape)o;
        if (p == null) return false;
        return CNTKLib.AreEqualShape(this, p);
    }

    public boolean equals(NDShape p) {
        if (p == null) return false;
        return CNTKLib.AreEqualShape(this, p);
    }

    @Override
    public int hashCode() {
        return GetDimensions().hashCode();
    }

%}

%typemap(javacode) CNTK::NDMask %{
%}

%typemap(javacode) CNTK::Value %{
%}

%typemap(javacode) CNTK::NDArrayView %{
%}

%include "CNTKLibraryInternals.h"
%include "CNTKLibrary.h"
