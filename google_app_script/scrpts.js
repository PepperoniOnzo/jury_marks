const Actions = {
  getInitialData: "getInitialData",

  postMarks: "postMarks"
}

const Settings =
{
  juryNames: "juryNames",
  teamNames: "teamNames",
  criteriaSequence: "criteriaSequence",
  criterias: "criterias",
  marks: "marks"
}

const SHEET_ID = "1YkGgsvc4_kmgKLCKq-oj5EuFTszxd9xH9BDCJXPjpGI";
const SHEET_SETTINGS = "settings";

function doPost(request) {
  try {
    var action = request.parameter.action;
    switch (action) {
      case Actions.postMarks:
        return postMarks(request);
      default:
        var result = { "status": "FAILED", "message": "No such action in POST" };
        return ContentService.createTextOutput(JSON.stringify(result)).setMimeType(ContentService.MimeType.JSON);
    }
  }
  catch (e) {
    var result = { "status": "FAILED", "message": 'Error ' + e.name + ":" + e.message + "\n" + e.stack };
    return ContentService.createTextOutput(JSON.stringify(result)).setMimeType(ContentService.MimeType.JSON);
  }

}

function doGet(request) {

  var action = request.parameter.action;
  switch (action) {
    case Actions.getInitialData:
      return getInitialData();
    case Actions.postMarks:
      return postMarks(request.parameters);
    default:
      var result = { "status": "FAILED", "message": "No such action in GET" };
      return ContentService.createTextOutput(JSON.stringify(result)).setMimeType(ContentService.MimeType.JSON);
  }
}

function postMarks(request) {
  var result = { "status": "SUCCESS" };

  try {
    var marks = request.marks;
    var teamName = request.teamName;
    var juryName = request.juryName;

    var sheet = SpreadsheetApp.openById(SHEET_ID).getSheetByName(teamName);

    var lastRow = sheet.getLastRow();
    var lastColumn = sheet.getLastColumn();

    for (i = 2; i <= lastRow; i++) {
      if (sheet.getRange(i, 1).getValue() == juryName) {
        for (z = 2; z <= lastColumn; z++) {
          sheet.getRange(i, z).setValue(marks[z - 2]);
        }
        break;
      }
    }
  }
  catch (e) {
    result = { "status": "FAILED", "message": 'Error ' + e.name + ":" + e.message + "\n" + e.stack };
  }

  return ContentService.createTextOutput(JSON.stringify(result)).setMimeType(ContentService.MimeType.JSON);
}

function mapToObj(map) {
  var obj = {}
  map.forEach(function (v, k) {
    obj[k] = v
  })
  return obj
}

function getInitialData() {
  var data = new Map();
  var result = { "status": "SUCCESS" };

  try {
    var tmp = JSON.parse(getNames(Settings.juryNames).getContent());
    if (tmp["status"] == "SUCCESS") {
      data.set(Settings.juryNames, tmp["data"]);
    }
    else {
      throw new UserException(tmp["message"]);
    }

    tmp = JSON.parse(getNames(Settings.teamNames).getContent());
    if (tmp["status"] == "SUCCESS") {
      data.set(Settings.teamNames, tmp["data"]);
    }
    else {
      throw new UserException(tmp["message"]);
    }

    tmp = JSON.parse(getNames(Settings.criteriaSequence).getContent());
    if (tmp["status"] == "SUCCESS") {
      data.set(Settings.criteriaSequence, tmp["data"]);
    }
    else {
      throw new UserException(tmp["message"]);
    }

    tmp = JSON.parse(getCriterias().getContent());
    if (tmp["status"] == "SUCCESS") {
      data.set(Settings.criterias, tmp["data"]);
    }
    else {
      throw new UserException(tmp["message"]);
    }


    var dataTeam = new Map();

    data.get(Settings.teamNames).forEach((team) => {
      tmp = JSON.parse(getMarks(team).getContent());
      if (tmp["status"] == "SUCCESS") {
        dataTeam.set(team, tmp["data"]);
      }
      else {
        throw new UserException(tmp["message"]);
      }
    });

    data.set(Settings.marks, mapToObj(dataTeam));

    result = { "status": "SUCCESS", "data": mapToObj(data) };
  }
  catch (e) {
    result = { "status": "FAILED", "message": e };
  }

  return ContentService.createTextOutput(JSON.stringify(result)).setMimeType(ContentService.MimeType.JSON);
}

function getNames(settings) {

  var sheet = SpreadsheetApp.openById(SHEET_ID).getSheetByName(SHEET_SETTINGS);
  var result;
  var tmp = [];

  var lastRow = sheet.getLastRow();
  var lastColumn = sheet.getLastColumn();

  for (i = 1; i <= lastRow; i++) {
    if (sheet.getRange(i, 1).getValue() == settings) {
      for (z = 2; z <= lastColumn; z++) {
        var tmpValue = sheet.getRange(i, z).getValue();
        if (tmpValue != "") {
          tmp.push(tmpValue);
        }
        else {
          break;
        }
      }
      break;
    }
  }

  if (tmp.length != 0) {
    result = { "status": "SUCCESS", "data": tmp };
  }
  else {
    result = { "status": "FAILED", "message": "Settings don`t have " };
  }

  return ContentService.createTextOutput(JSON.stringify(result)).setMimeType(ContentService.MimeType.JSON);
}

function getCriterias() {
  var sheet = SpreadsheetApp.openById(SHEET_ID).getSheetByName(SHEET_SETTINGS);
  var result;
  var tmp = new Map();

  var lastRow = sheet.getLastRow();

  for (i = 1; i <= lastRow; i++) {
    if (sheet.getRange(i, 1).getValue() == Settings.criterias) {
      for (z = i + 1; z <= lastRow; z++) {
        tmp.set(sheet.getRange(z, 1).getValue(), sheet.getRange(z, 2, 1, 5).getValues()[0])
      }
      break;
    }
  }

  if (tmp.length != 0) {
    result = { "status": "SUCCESS", "data": mapToObj(tmp) };
  }
  else {
    result = { "status": "FAILED", "message": "Settings don`t have " };
  }

  return ContentService.createTextOutput(JSON.stringify(result)).setMimeType(ContentService.MimeType.JSON);
}

function getMarks(team) {
  var sheet;
  try {
    var sheet = SpreadsheetApp.openById(SHEET_ID).getSheetByName(team);
  }
  catch (e) {
    return ContentService.createTextOutput(JSON.stringify({ "status": "FAILED", "message": "Spreadsheet don`t have team with name " + team })).setMimeType(ContentService.MimeType.JSON);
  }

  var result;
  var tmp = new Map();

  var lastRow = sheet.getLastRow();
  var lastColumn = sheet.getLastColumn();

  for (i = 2; i <= lastRow; i++) {
    tmp.set(sheet.getRange(i, 1).getValue(), sheet.getRange(i, 2, 1, lastColumn - 1).getValues()[0])
  }

  if (tmp.length != 0) {
    result = { "status": "SUCCESS", "data": mapToObj(tmp) };
  }
  else {
    result = { "status": "FAILED", "message": "Settings don`t have " };
  }

  return ContentService.createTextOutput(JSON.stringify(result)).setMimeType(ContentService.MimeType.JSON);
}































