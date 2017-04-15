%module pylibmpsse
%{
#include "mpsse.h"
%}

%typemap(in) (char *data, int size)
{
        if(!PyBytes_Check($input))
        {
                PyErr_SetString(PyExc_ValueError, "Bytes value required");
                return NULL;
        }

        $1 = PyBytes_AsString($input);
        $2 = PyBytes_Size($input);
}

%typemap(out) swig_string_data
{
        $result = PyBytes_FromStringAndSize($1.data, $1.size);
        free($1.data);
}

%include "mpsse.h"
