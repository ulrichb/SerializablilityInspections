﻿using System;
using System.Runtime.Serialization;

namespace SerializationInspections.Sample.Highlighting
{
    [Serializable]
    public class CustomSerializableWithDeserializationConstructor : ISerializable
    {
        public string Serialized;
        public string NonSerialized;

        public CustomSerializableWithDeserializationConstructor()
        {
        }

        private CustomSerializableWithDeserializationConstructor(SerializationInfo info, StreamingContext context)
        {
            Serialized = info.GetString("Serialized");
        }

        public void GetObjectData(SerializationInfo info, StreamingContext context)
        {
            info.AddValue("Serialized", Serialized);
        }
    }

    public class CustomSerializableWithDeserializationConstructorButNoSerializableAttribute : ISerializable
    {
        public CustomSerializableWithDeserializationConstructorButNoSerializableAttribute()
        {
        }

        private CustomSerializableWithDeserializationConstructorButNoSerializableAttribute(SerializationInfo info, StreamingContext context)
        {
        }

        public void GetObjectData(SerializationInfo info, StreamingContext context)
        {
        }
    }

    [Serializable]
    public class CustomSerializableWithoutDeserializationConstructor : ISerializable
    {
        public void GetObjectData(SerializationInfo info, StreamingContext context)
        {
        }
    }

    public class CustomSerializableWithoutSerializableAttributeAndDeserializationConstructor : ISerializable
    {
        public void GetObjectData(SerializationInfo info, StreamingContext context)
        {
        }
    }
}