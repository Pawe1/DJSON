unit Serializers;

interface

uses DJSON.Serializers, System.Rtti, System.JSON, JsonDataObjects,
  System.JSON.Writers, System.JSON.Readers;

type

  // DelphiDOM engine custom serializer
  TNumTelCustomSerializerDOM = class(TdjDOMCustomSerializer)
  public
    class function Serialize(const AValue:TValue): TJSONValue; override;
    class function Deserialize(const AJSONValue:TJSONValue; const AExistingValue:TValue): TValue; override;
    class function isTypeNotificationCompatible: Boolean; override;
  end;

  // JDO engine custom serializer
  TNumTelCustomSerializerJDO = class(TdjJDOCustomSerializer)
  public
    class procedure Serialize(const AJSONValue:PJsonDataValue; const AValue:TValue); override;
    class function Deserialize(const AJSONValue:PJsonDataValue; const AExistingValue:TValue): TValue; override;
    class function isTypeNotificationCompatible: Boolean; override;
  end;

  // DelphiStream engine custom serializer
  TNumTelCustomSerializerStream = class(TdjStreamCustomSerializer)
  public
    class procedure Serialize(const AJSONWriter: TJSONWriter; const AValue:TValue); override;
    class function Deserialize(const AJSONReader: TJSONReader; const AExistingValue:TValue): TValue; override;
    class function isTypeNotificationCompatible: Boolean; override;
  end;

implementation

uses
  Model, System.SysUtils, System.Classes;

{ TPhoneNumberCustomSerializer }

class function TNumTelCustomSerializerDOM.Deserialize(const AJSONValue: TJSONValue;
  const AExistingValue: TValue): TValue;
var
  LStringList: TStrings;
  LPhoneNumber: TPhoneNumber;
begin
  LStringList := TStringList.Create;
  try
    LStringList.CommaText := AJSONValue.Value;
    LPhoneNumber := TPhoneNumber.Create(LStringList[0].ToInteger, LStringList[2], LStringList[1].ToInteger);
    Result := TValue.From<TPhoneNumber>(LPhoneNumber);
  finally
    LStringList.Free;
  end;
end;

class function TNumTelCustomSerializerDOM.isTypeNotificationCompatible: Boolean;
begin
  Result := True;
end;

class function TNumTelCustomSerializerDOM.Serialize(const AValue: TValue): TJSONValue;
var
  LStringList: TStrings;
  LPhoneNumber: TPhoneNumber;
begin
  LPhoneNumber := AValue.AsType<TPhoneNumber>;
  LStringList := TStringList.Create;
  try
    LStringList.Add(LPhoneNumber.ID.ToString);
    LStringList.Add(LPhoneNumber.MasterID.ToString);
    LStringList.Add(LPhoneNumber.Number);
    Result := TJSONString.Create(LStringList.CommaText);
  finally
    LStringList.Free;
  end;
end;

{ TNumTelCustomSerializerJDO }

class function TNumTelCustomSerializerJDO.Deserialize(
  const AJSONValue: PJsonDataValue; const AExistingValue: TValue): TValue;
var
  LStringList: TStrings;
  LPhoneNumber: TPhoneNumber;
begin
  LStringList := TStringList.Create;
  try
    LStringList.CommaText := AJSONValue.Value;
    LPhoneNumber := TPhoneNumber.Create(LStringList[0].ToInteger, LStringList[2], LStringList[1].ToInteger);
    Result := TValue.From<TPhoneNumber>(LPhoneNumber);
  finally
    LStringList.Free;
  end;
end;

class function TNumTelCustomSerializerJDO.isTypeNotificationCompatible: Boolean;
begin
  Result := True;
end;

class procedure TNumTelCustomSerializerJDO.Serialize(
  const AJSONValue: PJsonDataValue; const AValue: TValue);
var
  LStringList: TStrings;
  LPhoneNumber: TPhoneNumber;
begin
  LPhoneNumber := AValue.AsType<TPhoneNumber>;
  LStringList := TStringList.Create;
  try
    LStringList.Add(LPhoneNumber.ID.ToString);
    LStringList.Add(LPhoneNumber.MasterID.ToString);
    LStringList.Add(LPhoneNumber.Number);
    AJSONValue.Value := LStringList.CommaText;
  finally
    LStringList.Free;
  end;
end;

{ TNumTelCustomSerializerSTream }

class function TNumTelCustomSerializerStream.Deserialize(
  const AJSONReader: TJSONReader; const AExistingValue: TValue): TValue;
var
  LStringList: TStrings;
  LPhoneNumber: TPhoneNumber;
begin
  LStringList := TStringList.Create;
  try
    LStringList.CommaText := AJSONReader.Value.AsString;
    LPhoneNumber := TPhoneNumber.Create(LStringList[0].ToInteger, LStringList[2], LStringList[1].ToInteger);
    Result := TValue.From<TPhoneNumber>(LPhoneNumber);
  finally
    LStringList.Free;
  end;
end;

class function TNumTelCustomSerializerStream.isTypeNotificationCompatible: Boolean;
begin
  Result := True;
end;

class procedure TNumTelCustomSerializerStream.Serialize(
  const AJSONWriter: TJSONWriter; const AValue: TValue);
var
  LStringList: TStrings;
  LPhoneNumber: TPhoneNumber;
begin
  LPhoneNumber := AValue.AsType<TPhoneNumber>;
  LStringList := TStringList.Create;
  try
    LStringList.Add(LPhoneNumber.ID.ToString);
    LStringList.Add(LPhoneNumber.MasterID.ToString);
    LStringList.Add(LPhoneNumber.Number);
    AJSONWriter.WriteValue(LStringList.CommaText);
  finally
    LStringList.Free;
  end;
end;

end.
