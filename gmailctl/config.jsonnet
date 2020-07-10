local lib = import 'gmailctl.libsonnet';

local toMe = [
  { to: 'jjanz@redhat.com' },
  { to: 'jonas.janz@redhat.com' },
];

local favorites = [
  { from: 'burr.sutter@redhat.com' },
  { from: 'mpfuetzn@redhat.com' },
  { from: 'matthias.pfuetzner@redhat.com' },
  { from: 'mpfuetzner@redhat.com' },
  { from: 'rbohne@redhat.com' },
  { from: 'rbo@redhat.com' },
  { from: 'robert.bohne@redhat.com' },
  { from: 'sfaulhab@redhat.com' },
  { from: 'knoblich@redhat.com' },
  { from: 'delisa@redhat.com' },
  { from: 'rlindner@redhat.com' },
  { from: 'juhoffma@redhat.com' },
  { from: 'buddy@redhat.com' },
  { from: 'jhoffmann@redhat.com' },
  { from: 'karsten.gresch@redhat.com' },
  { from: 'kgresch@redhat.com' },
];

local label_archive(filter, label) =
  [
  {
    filter: filter,
    actions: {
      archive: true,
      markSpam: false,
      labels: [ label ]
    }
  }
  ]
;

local rh_mailing_list(name, label = '') =
  local labels =
      if label == '' then
          [ std.join('/', std.splitLimit(name, '-', 1) ) ]
      else
          [ label ]
  ;
  local mailing_list_identifier = { list: name + '.redhat.com' };
  lib.chainFilters(
    [
      {
        filter: {
          and: [
            mailing_list_identifier,
          ] + toMe,
        },
        actions: {
          archive: false,
          markSpam: false,
          markRead: false,
          labels: labels
        }
      },
      {
        filter: { 
          and: [
            mailing_list_identifier,
          ] + favorites,
        },
        actions: {
          archive: false,
          markSpam: false,
          markRead: false,
          labels: labels
        }
      },
      {
        filter: {
          and: [
            mailing_list_identifier,
          ],
        },
        actions: {
          archive: true,
          markSpam: false,
          markRead: true,
          labels: labels
        }
      }
    ]
  )
;

{
  version: "v1alpha3",
  author: {
    name: "Jonas Janz",
    email: "jjanz@redhat.com"
  },
  rules:
    rh_mailing_list('announce-list', 'announce') +
    rh_mailing_list('memo-list', 'discussion/memo') +
    rh_mailing_list('openshift-sme', 'sme/openshift') +
    rh_mailing_list('sa-dach', 'sa/dach') +
    rh_mailing_list('sme-eap', 'sme/eap') +
    label_archive({from: 'kundenservice@egencia.de'}, '_tracker/egencia') +
    label_archive({from: 'people-helpdesk@redhat.com'}, '_tracker/rh_service_now') +
    label_archive({from: 'redhat@service-now.com'}, '_tracker/rh_service_now') +
    label_archive({from: 'workflow@redhat.com'}, '_tracker/ebs_workflow') +
    label_archive({from: 'orangehrmlive.com'}, '_tracker/orange') +
    label_archive({from: 'concursolutions.com'}, '_tracker/concur') +
    label_archive({from: 'errata@redhat.com'}, '_tracker/errata') +
    [
      {
        filter: { query: "list:(.github.com)" },
        actions: {
            markSpam: false,
            labels: [ "_tracker/gh" ]
        }
      },
      {
        filter: {
            and: [
            { list: "(.github.com)" },
            { to: "-mention@noreply.github.com" },
            ]
        },
        actions: {
            archive: true,
            markSpam: false,
            labels: [ "_tracker/gh" ]
        }
      },
      {
        filter: {
            query: "to:(jjanz@redhat.com OR jonas.janz@redhat.com) (*.ics OR *.vcs) has:attachment"
        },
        actions: {
            labels: [
            "invitations"
            ],
            archive: true,
            markSpam: false
        }
      },
    ]
}