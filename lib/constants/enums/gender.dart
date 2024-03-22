enum Gender { male, female, other, notHave }

Map<Gender, String> genderToString = {
  Gender.male: "Male",
  Gender.female: "Female",
  Gender.other: "Other",
};

Map<String, Gender> stringToGender = {
  "Male": Gender.male,
  "Female": Gender.female,
  "Other": Gender.other,
};
