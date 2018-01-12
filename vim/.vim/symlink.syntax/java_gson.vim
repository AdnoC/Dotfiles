if exists("java_highlight_all")  || exists("java_highlight_com") 
  " com
  JavaHiLink javaR_Com javaR_
  JavaHiLink javaC_Com javaC_
  JavaHiLink javaX_Com javaX_

endif

if exists("java_highlight_all")  || exists("java_highlight_com")  || exists("java_highlight_com_google") 
  " com.google
  JavaHiLink javaR_ComGoogle javaR_Com
  JavaHiLink javaC_ComGoogle javaC_Com
  JavaHiLink javaX_ComGoogle javaX_Com

endif

if exists("java_highlight_all")  || exists("java_highlight_com")  || exists("java_highlight_com_google")  || exists("java_highlight_com_google_gson") 
  " com.google.gson
  syn keyword javaR_ComGoogleGson JsonParseException JsonSyntaxException JsonIOException
  syn cluster javaTop add=javaR_ComGoogleGson
  syn cluster javaClasses add=javaR_ComGoogleGson
  JavaHiLink javaR_ComGoogleGson javaR_ComGoogle
  syn keyword javaC_ComGoogleGson JsonObject JsonElement FutureTypeAdapter JsonStreamParser GsonBuilder JsonArray SingleTypeFactory JsonPrimitive TypeAdapter FieldNamingPolicy DefaultDateTypeAdapter FieldAttributes Gson JsonParser TreeTypeAdapter JsonNull LongSerializationPolicy
  syn cluster javaTop add=javaC_ComGoogleGson
  syn cluster javaClasses add=javaC_ComGoogleGson
  JavaHiLink javaC_ComGoogleGson javaC_ComGoogle
  JavaHiLink javaX_ComGoogleGson javaX_ComGoogle

endif


if exists("java_highlight_all")  || exists("java_highlight_com")  || exists("java_highlight_com_google")  || exists("java_highlight_com_google_gson")  || exists("java_highlight_com_google_gson_internal") 
  " com.google.gson.internal
  syn keyword javaC_ComGoogleGsonInternal Types EntrySet CurrentWrite LinkedTreeMap GenericArrayTypeImpl Streams Excluder 11 ParameterizedTypeImpl Primitives 12 AppendableWriter LinkedTreeMapIterator Preconditions 10 WildcardTypeImpl Node UnsafeAllocator KeySet JsonReaderInternalAccess ConstructorConstructor LazilyParsedNumber
  syn cluster javaTop add=javaC_ComGoogleGsonInternal
  syn cluster javaClasses add=javaC_ComGoogleGsonInternal
  JavaHiLink javaC_ComGoogleGsonInternal javaC_ComGoogleGson

endif

if exists("java_highlight_all")  || exists("java_highlight_com")  || exists("java_highlight_com_google")  || exists("java_highlight_com_google_gson")  || exists("java_highlight_com_google_gson_internal")  || exists("java_highlight_com_google_gson_internal_bind") 
  " com.google.gson.internal.bind
  syn keyword javaC_ComGoogleGsonInternalBind CollectionTypeAdapterFactory ObjectTypeAdapter TimeTypeAdapter 19 17 18 15 16 13 MapTypeAdapterFactory 14 11 TypeAdapterRuntimeTypeWrapper 12 21 20 JsonTreeReader TypeAdapters BoundField ReflectiveTypeAdapterFactory JsonTreeWriter EnumTypeAdapter 22 23 DateTypeAdapter 24 25 26 27 28 29 10 30 32 31 SqlDateTypeAdapter Adapter ArrayTypeAdapter
  syn cluster javaTop add=javaC_ComGoogleGsonInternalBind
  syn cluster javaClasses add=javaC_ComGoogleGsonInternalBind
  JavaHiLink javaC_ComGoogleGsonInternalBind javaC_ComGoogleGsonInternal

endif

if exists("java_highlight_all")  || exists("java_highlight_com")  || exists("java_highlight_com_google")  || exists("java_highlight_com_google_gson")  || exists("java_highlight_com_google_gson_reflect") 
  " com.google.gson.reflect
  syn keyword javaC_ComGoogleGsonReflect TypeToken
  syn cluster javaTop add=javaC_ComGoogleGsonReflect
  syn cluster javaClasses add=javaC_ComGoogleGsonReflect
  JavaHiLink javaC_ComGoogleGsonReflect javaC_ComGoogleGson

endif

if exists("java_highlight_all")  || exists("java_highlight_com")  || exists("java_highlight_com_google")  || exists("java_highlight_com_google_gson")  || exists("java_highlight_com_google_gson_stream") 
  " com.google.gson.stream
  syn keyword javaC_ComGoogleGsonStream JsonWriter JsonScope JsonReader JsonToken
  syn cluster javaTop add=javaC_ComGoogleGsonStream
  syn cluster javaClasses add=javaC_ComGoogleGsonStream
  JavaHiLink javaC_ComGoogleGsonStream javaC_ComGoogleGson
  syn keyword javaX_ComGoogleGsonStream MalformedJsonException
  syn cluster javaTop add=javaX_ComGoogleGsonStream
  syn cluster javaClasses add=javaX_ComGoogleGsonStream
  JavaHiLink javaX_ComGoogleGsonStream javaX_ComGoogleGson

endif

