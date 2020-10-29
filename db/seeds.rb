# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

IncidentType.create([{ description: 'Near Miss'},
                     { description: 'Crash'},
                     { description: 'Roadway Obstruction'},
                     { description: 'Hazardous Area'}])

IncidentSeverity.create([{ description: 'No Apparent Injury'},
                     { description: 'Possible Injury'},
                     { description: 'Suspected Minor Injury'},
                     { description: 'Suspected Serious Injury'},
                     { description: 'Fatal Injury'}])

Report.create([{ lat: 39.98460665, long: -82.91922267, incident_datetime: '2020-09-30T19:23:15.841Z',
                 incident_text: 'lorem ipsum 1 ...', incident_type_id: 1, incident_severity_id: 1 },
               { lat: 39.95800777, long: -82.97354855, incident_datetime: '2020-09-30T19:23:15.841Z',
                 incident_text: 'lorem ipsum 2 ...', incident_type_id: 2, incident_severity_id: 2 },
               { lat: 39.86176882, long: -83.17015774, incident_datetime: '2020-09-30T19:23:15.841Z',
                 incident_text: 'lorem ipsum 3 ...',incident_type_id: 3, incident_severity_id: 3 },
               { lat: 39.920211, long: -82.832104, incident_datetime: '2020-09-30T19:23:15.841Z',
                 incident_text: 'lorem ipsum 4 ...', incident_type_id: 4, incident_severity_id: 4 },
               { lat: 39.920211, long: -82.832104, incident_datetime: '2020-09-30',
                 incident_text: 'lorem ipsum 5 ...', incident_type_id: 4, incident_severity_id: 5 }])


