#ifdef SWIGCSHARP

SWIG_STD_VECTOR_ENHANCED(size_t)
SWIG_STD_VECTOR_ENHANCED(double)
SWIG_STD_VECTOR_ENHANCED(float)
SWIG_STD_VECTOR_ENHANCED(CNTK::Variable)
SWIG_STD_VECTOR_ENHANCED(CNTK::Axis)
SWIG_STD_VECTOR_ENHANCED(std::shared_ptr<CNTK::NDArrayView>)
SWIG_STD_VECTOR_ENHANCED(bool)
SWIG_STD_VECTOR_ENHANCED(CNTK::DeviceDescriptor)

#endif

%template(SizeTVector) std::vector<size_t>;
%template(DoubleVector) std::vector<double>;
%template(FloatVector) std::vector<float>;
%template(VariableVector) std::vector<CNTK::Variable>;
%template(AxisVector) std::vector<CNTK::Axis>;
%template(NDArrayViewPtrVector) std::vector<std::shared_ptr<CNTK::NDArrayView>>;
%template(BoolVector) std::vector<bool>;
%template(DeviceDescriptorVector) std::vector<CNTK::DeviceDescriptor>;
%template(SizeTVectorVector) std::vector<std::vector<size_t>>;
%template(FloatVectorVector) std::vector<std::vector<float>>;
%template(DoubleVectorVector) std::vector<std::vector<double>>;
%template(UnorderedMapVariableValuePtr) std::unordered_map<CNTK::Variable, std::shared_ptr<CNTK::Value>>;
%template(UnorderedMapVariableVariable) std::unordered_map<CNTK::Variable, CNTK::Variable>;
%template(FunctionPtrVector) std::vector<std::shared_ptr<CNTK::Function>>;
