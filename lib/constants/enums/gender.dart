enum Gender { male, female, other, notHave }

Map<Gender, String> genderToString = {
  Gender.male: "Male",
  Gender.female: "Female",
  Gender.other: "Other",
};

Map<String, Gender> stringToGender = {
  "male": Gender.male,
  "female": Gender.female,
  "other": Gender.other,
};
