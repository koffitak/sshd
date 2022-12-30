SSHD_CONFIG(5)                       BSD File Formats Manual                       SSHD_CONFIG(5)

NNAAMMEE
     sssshhdd__ccoonnffiigg — OpenSSH daemon configuration file

DDEESSCCRRIIPPTTIIOONN
     sshd(8) reads configuration data from _/_e_t_c_/_s_s_h_/_s_s_h_d___c_o_n_f_i_g (or the file specified with --ff on
     the command line).  The file contains keyword-argument pairs, one per line.  For each key‐
     word, the first obtained value will be used.  Lines starting with ‘#’ and empty lines are
     interpreted as comments.  Arguments may optionally be enclosed in double quotes (") in order
     to represent arguments containing spaces.

     Note that the Debian ooppeennsssshh--sseerrvveerr package sets several options as standard in
     _/_e_t_c_/_s_s_h_/_s_s_h_d___c_o_n_f_i_g which are not the default in sshd(8):

           ••   IInncclluuddee //eettcc//sssshh//sssshhdd__ccoonnffiigg..dd//**..ccoonnff
           ••   KKbbddIInntteerraaccttiivveeAAuutthheennttiiccaattiioonn no
           ••   XX1111FFoorrwwaarrddiinngg yes
           ••   PPrriinnttMMoottdd no
           ••   AAcccceeppttEEnnvv LANG LC_*
           ••   SSuubbssyysstteemm sftp /usr/lib/openssh/sftp-server
           ••   UUsseePPAAMM yes

     _/_e_t_c_/_s_s_h_/_s_s_h_d___c_o_n_f_i_g_._d_/_*_._c_o_n_f files are included at the start of the configuration file, so
     options set there will override those in _/_e_t_c_/_s_s_h_/_s_s_h_d___c_o_n_f_i_g_.

     The possible keywords and their meanings are as follows (note that keywords are case-insen‐
     sitive and arguments are case-sensitive):

     AAcccceeppttEEnnvv
             Specifies what environment variables sent by the client will be copied into the ses‐
             sion's environ(7).  See SSeennddEEnnvv and SSeettEEnnvv in ssh_config(5) for how to configure the
             client.  The TERM environment variable is always accepted whenever the client re‐
             quests a pseudo-terminal as it is required by the protocol.  Variables are specified
             by name, which may contain the wildcard characters ‘*’ and ‘?’.  Multiple environ‐
             ment variables may be separated by whitespace or spread across multiple AAcccceeppttEEnnvv
             directives.  Be warned that some environment variables could be used to bypass re‐
             stricted user environments.  For this reason, care should be taken in the use of
             this directive.  The default is not to accept any environment variables.

     AAddddrreessssFFaammiillyy
             Specifies which address family should be used by sshd(8).  Valid arguments are aannyy
             (the default), iinneett (use IPv4 only), or iinneett66 (use IPv6 only).

     AAlllloowwAAggeennttFFoorrwwaarrddiinngg
             Specifies whether ssh-agent(1) forwarding is permitted.  The default is yyeess.  Note
             that disabling agent forwarding does not improve security unless users are also de‐
             nied shell access, as they can always install their own forwarders.

     AAlllloowwGGrroouuppss
             This keyword can be followed by a list of group name patterns, separated by spaces.
             If specified, login is allowed only for users whose primary group or supplementary
             group list matches one of the patterns.  Only group names are valid; a numerical
             group ID is not recognized.  By default, login is allowed for all groups.  The al‐
             low/deny groups directives are processed in the following order: DDeennyyGGrroouuppss,
             AAlllloowwGGrroouuppss.

             See PATTERNS in ssh_config(5) for more information on patterns.

     AAlllloowwSSttrreeaammLLooccaallFFoorrwwaarrddiinngg
             Specifies whether StreamLocal (Unix-domain socket) forwarding is permitted.  The
             available options are yyeess (the default) or aallll to allow StreamLocal forwarding, nnoo
             to prevent all StreamLocal forwarding, llooccaall to allow local (from the perspective of
             ssh(1)) forwarding only or rreemmoottee to allow remote forwarding only.  Note that dis‐
             abling StreamLocal forwarding does not improve security unless users are also denied
             shell access, as they can always install their own forwarders.

     AAlllloowwTTccppFFoorrwwaarrddiinngg
             Specifies whether TCP forwarding is permitted.  The available options are yyeess (the
             default) or aallll to allow TCP forwarding, nnoo to prevent all TCP forwarding, llooccaall to
             allow local (from the perspective of ssh(1)) forwarding only or rreemmoottee to allow re‐
             mote forwarding only.  Note that disabling TCP forwarding does not improve security
             unless users are also denied shell access, as they can always install their own for‐
             warders.

     AAlllloowwUUsseerrss
             This keyword can be followed by a list of user name patterns, separated by spaces.
             If specified, login is allowed only for user names that match one of the patterns.
             Only user names are valid; a numerical user ID is not recognized.  By default, login
             is allowed for all users.  If the pattern takes the form USER@HOST then USER and
             HOST are separately checked, restricting logins to particular users from particular
             hosts.  HOST criteria may additionally contain addresses to match in CIDR ad‐
             dress/masklen format.  The allow/deny users directives are processed in the follow‐
             ing order: DDeennyyUUsseerrss, AAlllloowwUUsseerrss.

             See PATTERNS in ssh_config(5) for more information on patterns.

     AAuutthheennttiiccaattiioonnMMeetthhooddss
             Specifies the authentication methods that must be successfully completed for a user
             to be granted access.  This option must be followed by one or more lists of comma-
             separated authentication method names, or by the single string aannyy to indicate the
             default behaviour of accepting any single authentication method.  If the default is
             overridden, then successful authentication requires completion of every method in at
             least one of these lists.

             For example, "publickey,password publickey,keyboard-interactive" would require the
             user to complete public key authentication, followed by either password or keyboard
             interactive authentication.  Only methods that are next in one or more lists are of‐
             fered at each stage, so for this example it would not be possible to attempt pass‐
             word or keyboard-interactive authentication before public key.

             For keyboard interactive authentication it is also possible to restrict authentica‐
             tion to a specific device by appending a colon followed by the device identifier
             bbssddaauutthh or ppaamm.  depending on the server configuration.  For example,
             "keyboard-interactive:bsdauth" would restrict keyboard interactive authentication to
             the bbssddaauutthh device.

             If the publickey method is listed more than once, sshd(8) verifies that keys that
             have been used successfully are not reused for subsequent authentications.  For ex‐
             ample, "publickey,publickey" requires successful authentication using two different
             public keys.

             Note that each authentication method listed should also be explicitly enabled in the
             configuration.

             The available authentication methods are: "gssapi-with-mic", "hostbased",
             "keyboard-interactive", "none" (used for access to password-less accounts when
             PPeerrmmiittEEmmppttyyPPaasssswwoorrddss is enabled), "password" and "publickey".

     AAuutthhoorriizzeeddKKeeyyssCCoommmmaanndd
             Specifies a program to be used to look up the user's public keys.  The program must
             be owned by root, not writable by group or others and specified by an absolute path.
             Arguments to AAuutthhoorriizzeeddKKeeyyssCCoommmmaanndd accept the tokens described in the _T_O_K_E_N_S sec‐
             tion.  If no arguments are specified then the username of the target user is used.

             The program should produce on standard output zero or more lines of authorized_keys
             output (see _A_U_T_H_O_R_I_Z_E_D___K_E_Y_S in sshd(8)).  AAuutthhoorriizzeeddKKeeyyssCCoommmmaanndd is tried after the
             usual AAuutthhoorriizzeeddKKeeyyssFFiillee files and will not be executed if a matching key is found
             there.  By default, no AAuutthhoorriizzeeddKKeeyyssCCoommmmaanndd is run.

     AAuutthhoorriizzeeddKKeeyyssCCoommmmaannddUUsseerr
             Specifies the user under whose account the AAuutthhoorriizzeeddKKeeyyssCCoommmmaanndd is run.  It is rec‐
             ommended to use a dedicated user that has no other role on the host than running au‐
             thorized keys commands.  If AAuutthhoorriizzeeddKKeeyyssCCoommmmaanndd is specified but
             AAuutthhoorriizzeeddKKeeyyssCCoommmmaannddUUsseerr is not, then sshd(8) will refuse to start.

     AAuutthhoorriizzeeddKKeeyyssFFiillee
             Specifies the file that contains the public keys used for user authentication.  The
             format is described in the AUTHORIZED_KEYS FILE FORMAT section of sshd(8).  Argu‐
             ments to AAuutthhoorriizzeeddKKeeyyssFFiillee accept the tokens described in the _T_O_K_E_N_S section.  Af‐
             ter expansion, AAuutthhoorriizzeeddKKeeyyssFFiillee is taken to be an absolute path or one relative to
             the user's home directory.  Multiple files may be listed, separated by whitespace.
             Alternately this option may be set to nnoonnee to skip checking for user keys in files.
             The default is ".ssh/authorized_keys .ssh/authorized_keys2".

     AAuutthhoorriizzeeddPPrriinncciippaallssCCoommmmaanndd
             Specifies a program to be used to generate the list of allowed certificate princi‐
             pals as per AAuutthhoorriizzeeddPPrriinncciippaallssFFiillee.  The program must be owned by root, not
             writable by group or others and specified by an absolute path.  Arguments to
             AAuutthhoorriizzeeddPPrriinncciippaallssCCoommmmaanndd accept the tokens described in the _T_O_K_E_N_S section.  If
             no arguments are specified then the username of the target user is used.

             The program should produce on standard output zero or more lines of
             AAuutthhoorriizzeeddPPrriinncciippaallssFFiillee output.  If either AAuutthhoorriizzeeddPPrriinncciippaallssCCoommmmaanndd or
             AAuutthhoorriizzeeddPPrriinncciippaallssFFiillee is specified, then certificates offered by the client for
             authentication must contain a principal that is listed.  By default, no
             AAuutthhoorriizzeeddPPrriinncciippaallssCCoommmmaanndd is run.

     AAuutthhoorriizzeeddPPrriinncciippaallssCCoommmmaannddUUsseerr
             Specifies the user under whose account the AAuutthhoorriizzeeddPPrriinncciippaallssCCoommmmaanndd is run.  It
             is recommended to use a dedicated user that has no other role on the host than run‐
             ning authorized principals commands.  If AAuutthhoorriizzeeddPPrriinncciippaallssCCoommmmaanndd is specified
             but AAuutthhoorriizzeeddPPrriinncciippaallssCCoommmmaannddUUsseerr is not, then sshd(8) will refuse to start.

     AAuutthhoorriizzeeddPPrriinncciippaallssFFiillee
             Specifies a file that lists principal names that are accepted for certificate au‐
             thentication.  When using certificates signed by a key listed in TTrruusstteeddUUsseerrCCAAKKeeyyss,
             this file lists names, one of which must appear in the certificate for it to be ac‐
             cepted for authentication.  Names are listed one per line preceded by key options
             (as described in _A_U_T_H_O_R_I_Z_E_D___K_E_Y_S _F_I_L_E _F_O_R_M_A_T in sshd(8)).  Empty lines and comments
             starting with ‘#’ are ignored.

             Arguments to AAuutthhoorriizzeeddPPrriinncciippaallssFFiillee accept the tokens described in the _T_O_K_E_N_S sec‐
             tion.  After expansion, AAuutthhoorriizzeeddPPrriinncciippaallssFFiillee is taken to be an absolute path or
             one relative to the user's home directory.  The default is nnoonnee, i.e. not to use a
             principals file – in this case, the username of the user must appear in a certifi‐
             cate's principals list for it to be accepted.

             Note that AAuutthhoorriizzeeddPPrriinncciippaallssFFiillee is only used when authentication proceeds using a
             CA listed in TTrruusstteeddUUsseerrCCAAKKeeyyss and is not consulted for certification authorities
             trusted via _~_/_._s_s_h_/_a_u_t_h_o_r_i_z_e_d___k_e_y_s, though the pprriinncciippaallss== key option offers a simi‐
             lar facility (see sshd(8) for details).

     BBaannnneerr  The contents of the specified file are sent to the remote user before authentication
             is allowed.  If the argument is nnoonnee then no banner is displayed.  By default, no
             banner is displayed.

     CCAASSiiggnnaattuurreeAAllggoorriitthhmmss
             Specifies which algorithms are allowed for signing of certificates by certificate
             authorities (CAs).  The default is:

                   ssh-ed25519,ecdsa-sha2-nistp256,
                   ecdsa-sha2-nistp384,ecdsa-sha2-nistp521,
                   sk-ssh-ed25519@openssh.com,
                   sk-ecdsa-sha2-nistp256@openssh.com,
                   rsa-sha2-512,rsa-sha2-256

             If the specified list begins with a ‘+’ character, then the specified algorithms
             will be appended to the default set instead of replacing them.  If the specified
             list begins with a ‘-’ character, then the specified algorithms (including wild‐
             cards) will be removed from the default set instead of replacing them.

             Certificates signed using other algorithms will not be accepted for public key or
             host-based authentication.

     CChhrroooottDDiirreeccttoorryy
             Specifies the pathname of a directory to chroot(2) to after authentication.  At ses‐
             sion startup sshd(8) checks that all components of the pathname are root-owned di‐
             rectories which are not writable by any other user or group.  After the chroot,
             sshd(8) changes the working directory to the user's home directory.  Arguments to
             CChhrroooottDDiirreeccttoorryy accept the tokens described in the _T_O_K_E_N_S section.

             The CChhrroooottDDiirreeccttoorryy must contain the necessary files and directories to support the
             user's session.  For an interactive session this requires at least a shell, typi‐
             cally sh(1), and basic _/_d_e_v nodes such as null(4), zero(4), stdin(4), stdout(4),
             stderr(4), and tty(4) devices.  For file transfer sessions using SFTP no additional
             configuration of the environment is necessary if the in-process sftp-server is used,
             though sessions which use logging may require _/_d_e_v_/_l_o_g inside the chroot directory
             on some operating systems (see sftp-server(8) for details).

             For safety, it is very important that the directory hierarchy be prevented from mod‐
             ification by other processes on the system (especially those outside the jail).
             Misconfiguration can lead to unsafe environments which sshd(8) cannot detect.

             The default is nnoonnee, indicating not to chroot(2).

     CCiipphheerrss
             Specifies the ciphers allowed.  Multiple ciphers must be comma-separated.  If the
             specified list begins with a ‘+’ character, then the specified ciphers will be ap‐
             pended to the default set instead of replacing them.  If the specified list begins
             with a ‘-’ character, then the specified ciphers (including wildcards) will be re‐
             moved from the default set instead of replacing them.  If the specified list begins
             with a ‘^’ character, then the specified ciphers will be placed at the head of the
             default set.

             The supported ciphers are:

                   3des-cbc
                   aes128-cbc
                   aes192-cbc
                   aes256-cbc
                   aes128-ctr
                   aes192-ctr
                   aes256-ctr
                   aes128-gcm@openssh.com
                   aes256-gcm@openssh.com
                   chacha20-poly1305@openssh.com

             The default is:

                   chacha20-poly1305@openssh.com,
                   aes128-ctr,aes192-ctr,aes256-ctr,
                   aes128-gcm@openssh.com,aes256-gcm@openssh.com

             The list of available ciphers may also be obtained using "ssh -Q cipher".

     CClliieennttAAlliivveeCCoouunnttMMaaxx
             Sets the number of client alive messages which may be sent without sshd(8) receiving
             any messages back from the client.  If this threshold is reached while client alive
             messages are being sent, sshd will disconnect the client, terminating the session.
             It is important to note that the use of client alive messages is very different from
             TTCCPPKKeeeeppAAlliivvee.  The client alive messages are sent through the encrypted channel and
             therefore will not be spoofable.  The TCP keepalive option enabled by TTCCPPKKeeeeppAAlliivvee
             is spoofable.  The client alive mechanism is valuable when the client or server de‐
             pend on knowing when a connection has become unresponsive.

             The default value is 3.  If CClliieennttAAlliivveeIInntteerrvvaall is set to 15, and
             CClliieennttAAlliivveeCCoouunnttMMaaxx is left at the default, unresponsive SSH clients will be discon‐
             nected after approximately 45 seconds.  Setting a zero CClliieennttAAlliivveeCCoouunnttMMaaxx disables
             connection termination.

     CClliieennttAAlliivveeIInntteerrvvaall
             Sets a timeout interval in seconds after which if no data has been received from the
             client, sshd(8) will send a message through the encrypted channel to request a re‐
             sponse from the client.  The default is 0, indicating that these messages will not
             be sent to the client.

     CCoommpprreessssiioonn
             Specifies whether compression is enabled after the user has authenticated success‐
             fully.  The argument must be yyeess, ddeellaayyeedd (a legacy synonym for yyeess) or nnoo.  The de‐
             fault is yyeess.

     DDeebbiiaannBBaannnneerr
             Specifies whether the distribution-specified extra version suffix is included during
             initial protocol handshake.  The default is yyeess.

     DDeennyyGGrroouuppss
             This keyword can be followed by a list of group name patterns, separated by spaces.
             Login is disallowed for users whose primary group or supplementary group list
             matches one of the patterns.  Only group names are valid; a numerical group ID is
             not recognized.  By default, login is allowed for all groups.  The allow/deny groups
             directives are processed in the following order: DDeennyyGGrroouuppss, AAlllloowwGGrroouuppss.

             See PATTERNS in ssh_config(5) for more information on patterns.

     DDeennyyUUsseerrss
             This keyword can be followed by a list of user name patterns, separated by spaces.
             Login is disallowed for user names that match one of the patterns.  Only user names
             are valid; a numerical user ID is not recognized.  By default, login is allowed for
             all users.  If the pattern takes the form USER@HOST then USER and HOST are sepa‐
             rately checked, restricting logins to particular users from particular hosts.  HOST
             criteria may additionally contain addresses to match in CIDR address/masklen format.
             The allow/deny users directives are processed in the following order: DDeennyyUUsseerrss,
             AAlllloowwUUsseerrss.

             See PATTERNS in ssh_config(5) for more information on patterns.

     DDiissaabblleeFFoorrwwaarrddiinngg
             Disables all forwarding features, including X11, ssh-agent(1), TCP and StreamLocal.
             This option overrides all other forwarding-related options and may simplify re‐
             stricted configurations.

     EExxppoosseeAAuutthhIInnffoo
             Writes a temporary file containing a list of authentication methods and public cre‐
             dentials (e.g. keys) used to authenticate the user.  The location of the file is ex‐
             posed to the user session through the SSH_USER_AUTH environment variable.  The de‐
             fault is nnoo.

     FFiinnggeerrpprriinnttHHaasshh
             Specifies the hash algorithm used when logging key fingerprints.  Valid options are:
             mmdd55 and sshhaa225566.  The default is sshhaa225566.

     FFoorrcceeCCoommmmaanndd
             Forces the execution of the command specified by FFoorrcceeCCoommmmaanndd, ignoring any command
             supplied by the client and _~_/_._s_s_h_/_r_c if present.  The command is invoked by using
             the user's login shell with the -c option.  This applies to shell, command, or sub‐
             system execution.  It is most useful inside a MMaattcchh block.  The command originally
             supplied by the client is available in the SSH_ORIGINAL_COMMAND environment vari‐
             able.  Specifying a command of iinntteerrnnaall--ssffttpp will force the use of an in-process
             SFTP server that requires no support files when used with CChhrroooottDDiirreeccttoorryy.  The de‐
             fault is nnoonnee.

     GGaatteewwaayyPPoorrttss
             Specifies whether remote hosts are allowed to connect to ports forwarded for the
             client.  By default, sshd(8) binds remote port forwardings to the loopback address.
             This prevents other remote hosts from connecting to forwarded ports.  GGaatteewwaayyPPoorrttss
             can be used to specify that sshd should allow remote port forwardings to bind to
             non-loopback addresses, thus allowing other hosts to connect.  The argument may be
             nnoo to force remote port forwardings to be available to the local host only, yyeess to
             force remote port forwardings to bind to the wildcard address, or cclliieennttssppeecciiffiieedd to
             allow the client to select the address to which the forwarding is bound.  The de‐
             fault is nnoo.

     GGSSSSAAPPIIAAuutthheennttiiccaattiioonn
             Specifies whether user authentication based on GSSAPI is allowed.  The default is
             nnoo.

     GGSSSSAAPPIICClleeaannuuppCCrreeddeennttiiaallss
             Specifies whether to automatically destroy the user's credentials cache on logout.
             The default is yyeess.

     GGSSSSAAPPIIKKeeyyEExxcchhaannggee
             Specifies whether key exchange based on GSSAPI is allowed. GSSAPI key exchange
             doesn't rely on ssh keys to verify host identity.  The default is nnoo.

     GGSSSSAAPPIISSttrriiccttAAcccceeppttoorrCChheecckk
             Determines whether to be strict about the identity of the GSSAPI acceptor a client
             authenticates against.  If set to yyeess then the client must authenticate against the
             host service on the current hostname.  If set to nnoo then the client may authenticate
             against any service key stored in the machine's default store.  This facility is
             provided to assist with operation on multi homed machines.  The default is yyeess.

     GGSSSSAAPPIISSttoorreeCCrreeddeennttiiaallssOOnnRReekkeeyy
             Controls whether the user's GSSAPI credentials should be updated following a suc‐
             cessful connection rekeying. This option can be used to accepted renewed or updated
             credentials from a compatible client. The default is “no”.

             For this to work GGSSSSAAPPIIKKeeyyEExxcchhaannggee needs to be enabled in the server and also used
             by the client.

     GGSSSSAAPPIIKKeexxAAllggoorriitthhmmss
             The list of key exchange algorithms that are accepted by GSSAPI key exchange. Possi‐
             ble values are

                gss-gex-sha1-,
                gss-group1-sha1-,
                gss-group14-sha1-,
                gss-group14-sha256-,
                gss-group16-sha512-,
                gss-nistp256-sha256-,
                gss-curve25519-sha256-

             The default is
             “gss-group14-sha256-,gss-group16-sha512-,gss-nistp256-sha256-,gss-curve25519-sha256-,gss-gex-sha1-,gss-group14-sha1-”.
             This option only applies to connections using GSSAPI.

     HHoossttbbaasseeddAAcccceepptteeddAAllggoorriitthhmmss
             Specifies the signature algorithms that will be accepted for hostbased authentica‐
             tion as a list of comma-separated patterns.  Alternately if the specified list be‐
             gins with a ‘+’ character, then the specified signature algorithms will be appended
             to the default set instead of replacing them.  If the specified list begins with a
             ‘-’ character, then the specified signature algorithms (including wildcards) will be
             removed from the default set instead of replacing them.  If the specified list be‐
             gins with a ‘^’ character, then the specified signature algorithms will be placed at
             the head of the default set.  The default for this option is:

                ssh-ed25519-cert-v01@openssh.com,
                ecdsa-sha2-nistp256-cert-v01@openssh.com,
                ecdsa-sha2-nistp384-cert-v01@openssh.com,
                ecdsa-sha2-nistp521-cert-v01@openssh.com,
                sk-ssh-ed25519-cert-v01@openssh.com,
                sk-ecdsa-sha2-nistp256-cert-v01@openssh.com,
                rsa-sha2-512-cert-v01@openssh.com,
                rsa-sha2-256-cert-v01@openssh.com,
                ssh-ed25519,
                ecdsa-sha2-nistp256,ecdsa-sha2-nistp384,ecdsa-sha2-nistp521,
                sk-ssh-ed25519@openssh.com,
                sk-ecdsa-sha2-nistp256@openssh.com,
                rsa-sha2-512,rsa-sha2-256

             The list of available signature algorithms may also be obtained using "ssh -Q
             HostbasedAcceptedAlgorithms".  This was formerly named HostbasedAcceptedKeyTypes.

     HHoossttbbaasseeddAAuutthheennttiiccaattiioonn
             Specifies whether rhosts or /etc/hosts.equiv authentication together with successful
             public key client host authentication is allowed (host-based authentication).  The
             default is nnoo.

     HHoossttbbaasseeddUUsseessNNaammeeFFrroommPPaacckkeettOOnnllyy
             Specifies whether or not the server will attempt to perform a reverse name lookup
             when matching the name in the _~_/_._s_h_o_s_t_s, _~_/_._r_h_o_s_t_s, and _/_e_t_c_/_h_o_s_t_s_._e_q_u_i_v files dur‐
             ing HHoossttbbaasseeddAAuutthheennttiiccaattiioonn.  A setting of yyeess means that sshd(8) uses the name sup‐
             plied by the client rather than attempting to resolve the name from the TCP connec‐
             tion itself.  The default is nnoo.

     HHoossttCCeerrttiiffiiccaattee
             Specifies a file containing a public host certificate.  The certificate's public key
             must match a private host key already specified by HHoossttKKeeyy.  The default behaviour
             of sshd(8) is not to load any certificates.

     HHoossttKKeeyy
             Specifies a file containing a private host key used by SSH.  The defaults are
             _/_e_t_c_/_s_s_h_/_s_s_h___h_o_s_t___e_c_d_s_a___k_e_y, _/_e_t_c_/_s_s_h_/_s_s_h___h_o_s_t___e_d_2_5_5_1_9___k_e_y and
             _/_e_t_c_/_s_s_h_/_s_s_h___h_o_s_t___r_s_a___k_e_y.

             Note that sshd(8) will refuse to use a file if it is group/world-accessible and that
             the HHoossttKKeeyyAAllggoorriitthhmmss option restricts which of the keys are actually used by
             sshd(8).

             It is possible to have multiple host key files.  It is also possible to specify pub‐
             lic host key files instead.  In this case operations on the private key will be del‐
             egated to an ssh-agent(1).

     HHoossttKKeeyyAAggeenntt
             Identifies the UNIX-domain socket used to communicate with an agent that has access
             to the private host keys.  If the string "SSH_AUTH_SOCK" is specified, the location
             of the socket will be read from the SSH_AUTH_SOCK environment variable.

     HHoossttKKeeyyAAllggoorriitthhmmss
             Specifies the host key signature algorithms that the server offers.  The default for
             this option is:

                ssh-ed25519-cert-v01@openssh.com,
                ecdsa-sha2-nistp256-cert-v01@openssh.com,
                ecdsa-sha2-nistp384-cert-v01@openssh.com,
                ecdsa-sha2-nistp521-cert-v01@openssh.com,
                sk-ssh-ed25519-cert-v01@openssh.com,
                sk-ecdsa-sha2-nistp256-cert-v01@openssh.com,
                rsa-sha2-512-cert-v01@openssh.com,
                rsa-sha2-256-cert-v01@openssh.com,
                ssh-ed25519,
                ecdsa-sha2-nistp256,ecdsa-sha2-nistp384,ecdsa-sha2-nistp521,
                sk-ssh-ed25519@openssh.com,
                sk-ecdsa-sha2-nistp256@openssh.com,
                rsa-sha2-512,rsa-sha2-256

             The list of available signature algorithms may also be obtained using "ssh -Q
             HostKeyAlgorithms".

     IIggnnoorreeRRhhoossttss
             Specifies whether to ignore per-user _._r_h_o_s_t_s and _._s_h_o_s_t_s files during
             HHoossttbbaasseeddAAuutthheennttiiccaattiioonn.  The system-wide _/_e_t_c_/_h_o_s_t_s_._e_q_u_i_v and _/_e_t_c_/_s_s_h_/_s_h_o_s_t_s_._e_q_u_i_v
             are still used regardless of this setting.

             Accepted values are yyeess (the default) to ignore all per-user files, sshhoossttss--oonnllyy to
             allow the use of _._s_h_o_s_t_s but to ignore _._r_h_o_s_t_s or nnoo to allow both _._s_h_o_s_t_s and
             _r_h_o_s_t_s.

     IIggnnoorreeUUsseerrKKnnoowwnnHHoossttss
             Specifies whether sshd(8) should ignore the user's _~_/_._s_s_h_/_k_n_o_w_n___h_o_s_t_s during
             HHoossttbbaasseeddAAuutthheennttiiccaattiioonn and use only the system-wide known hosts file
             _/_e_t_c_/_s_s_h_/_k_n_o_w_n___h_o_s_t_s.  The default is “no”.

     IInncclluuddee
             Include the specified configuration file(s).  Multiple pathnames may be specified
             and each pathname may contain glob(7) wildcards that will be expanded and processed
             in lexical order.  Files without absolute paths are assumed to be in _/_e_t_c_/_s_s_h.  An
             IInncclluuddee directive may appear inside a MMaattcchh block to perform conditional inclusion.

     IIPPQQooSS   Specifies the IPv4 type-of-service or DSCP class for the connection.  Accepted val‐
             ues are aaff1111, aaff1122, aaff1133, aaff2211, aaff2222, aaff2233, aaff3311, aaff3322, aaff3333, aaff4411, aaff4422, aaff4433, ccss00,
             ccss11, ccss22, ccss33, ccss44, ccss55, ccss66, ccss77, eeff, llee, lloowwddeellaayy, tthhrroouugghhppuutt, rreelliiaabbiilliittyy, a nu‐
             meric value, or nnoonnee to use the operating system default.  This option may take one
             or two arguments, separated by whitespace.  If one argument is specified, it is used
             as the packet class unconditionally.  If two values are specified, the first is au‐
             tomatically selected for interactive sessions and the second for non-interactive
             sessions.  The default is lloowwddeellaayy for interactive sessions and tthhrroouugghhppuutt for non-
             interactive sessions.

     KKbbddIInntteerraaccttiivveeAAuutthheennttiiccaattiioonn
             Specifies whether to allow keyboard-interactive authentication.  The default is yyeess.
             The argument to this keyword must be yyeess or nnoo.  CChhaalllleennggeeRReessppoonnsseeAAuutthheennttiiccaattiioonn is
             a deprecated alias for this.

     KKeerrbbeerroossAAuutthheennttiiccaattiioonn
             Specifies whether the password provided by the user for PPaasssswwoorrddAAuutthheennttiiccaattiioonn will
             be validated through the Kerberos KDC.  To use this option, the server needs a Ker‐
             beros servtab which allows the verification of the KDC's identity.  The default is
             nnoo.

     KKeerrbbeerroossGGeettAAFFSSTTookkeenn
             If AFS is active and the user has a Kerberos 5 TGT, attempt to acquire an AFS token
             before accessing the user's home directory.  The default is nnoo.

     KKeerrbbeerroossOOrrLLooccaallPPaasssswwdd
             If password authentication through Kerberos fails then the password will be vali‐
             dated via any additional local mechanism such as _/_e_t_c_/_p_a_s_s_w_d.  The default is yyeess.

     KKeerrbbeerroossTTiicckkeettCClleeaannuupp
             Specifies whether to automatically destroy the user's ticket cache file on logout.
             The default is yyeess.

     KKeexxAAllggoorriitthhmmss
             Specifies the available KEX (Key Exchange) algorithms.  Multiple algorithms must be
             comma-separated.  Alternately if the specified list begins with a ‘+’ character,
             then the specified algorithms will be appended to the default set instead of replac‐
             ing them.  If the specified list begins with a ‘-’ character, then the specified al‐
             gorithms (including wildcards) will be removed from the default set instead of re‐
             placing them.  If the specified list begins with a ‘^’ character, then the specified
             algorithms will be placed at the head of the default set.  The supported algorithms
             are:

                   curve25519-sha256
                   curve25519-sha256@libssh.org
                   diffie-hellman-group1-sha1
                   diffie-hellman-group14-sha1
                   diffie-hellman-group14-sha256
                   diffie-hellman-group16-sha512
                   diffie-hellman-group18-sha512
                   diffie-hellman-group-exchange-sha1
                   diffie-hellman-group-exchange-sha256
                   ecdh-sha2-nistp256
                   ecdh-sha2-nistp384
                   ecdh-sha2-nistp521
                   sntrup761x25519-sha512@openssh.com

             The default is:

                   curve25519-sha256,curve25519-sha256@libssh.org,
                   ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521,
                   sntrup761x25519-sha512@openssh.com,
                   diffie-hellman-group-exchange-sha256,
                   diffie-hellman-group16-sha512,diffie-hellman-group18-sha512,
                   diffie-hellman-group14-sha256

             The list of available key exchange algorithms may also be obtained using "ssh -Q
             KexAlgorithms".

     LLiisstteennAAddddrreessss
             Specifies the local addresses sshd(8) should listen on.  The following forms may be
             used:

                   LLiisstteennAAddddrreessss _h_o_s_t_n_a_m_e|_a_d_d_r_e_s_s
                   LLiisstteennAAddddrreessss _h_o_s_t_n_a_m_e:_p_o_r_t
                   LLiisstteennAAddddrreessss _I_P_v_4___a_d_d_r_e_s_s:_p_o_r_t
                   LLiisstteennAAddddrreessss [_h_o_s_t_n_a_m_e|_a_d_d_r_e_s_s]:_p_o_r_t

             If _p_o_r_t is not specified, sshd will listen on the address and all PPoorrtt options spec‐
             ified.  The default is to listen on all local addresses.  Multiple LLiisstteennAAddddrreessss op‐
             tions are permitted.

     LLooggiinnGGrraacceeTTiimmee
             The server disconnects after this time if the user has not successfully logged in.
             If the value is 0, there is no time limit.  The default is 120 seconds.

     LLooggLLeevveell
             Gives the verbosity level that is used when logging messages from sshd(8).  The pos‐
             sible values are: QUIET, FATAL, ERROR, INFO, VERBOSE, DEBUG, DEBUG1, DEBUG2, and DE‐
             BUG3.  The default is INFO.  DEBUG and DEBUG1 are equivalent.  DEBUG2 and DEBUG3
             each specify higher levels of debugging output.  Logging with a DEBUG level violates
             the privacy of users and is not recommended.

     LLooggVVeerrbboossee
             Specify one or more overrides to LogLevel.  An override consists of a pattern lists
             that matches the source file, function and line number to force detailed logging
             for.  For example, an override pattern of:

                   kex.c:*:1000,*:kex_exchange_identification():*,packet.c:*

             would enable detailed logging for line 1000 of _k_e_x_._c, everything in the
             kkeexx__eexxcchhaannggee__iiddeennttiiffiiccaattiioonn() function, and all code in the _p_a_c_k_e_t_._c file.  This op‐
             tion is intended for debugging and no overrides are enabled by default.

     MMAACCss    Specifies the available MAC (message authentication code) algorithms.  The MAC algo‐
             rithm is used for data integrity protection.  Multiple algorithms must be comma-sep‐
             arated.  If the specified list begins with a ‘+’ character, then the specified algo‐
             rithms will be appended to the default set instead of replacing them.  If the speci‐
             fied list begins with a ‘-’ character, then the specified algorithms (including
             wildcards) will be removed from the default set instead of replacing them.  If the
             specified list begins with a ‘^’ character, then the specified algorithms will be
             placed at the head of the default set.

             The algorithms that contain "-etm" calculate the MAC after encryption (encrypt-then-
             mac).  These are considered safer and their use recommended.  The supported MACs
             are:

                   hmac-md5
                   hmac-md5-96
                   hmac-sha1
                   hmac-sha1-96
                   hmac-sha2-256
                   hmac-sha2-512
                   umac-64@openssh.com
                   umac-128@openssh.com
                   hmac-md5-etm@openssh.com
                   hmac-md5-96-etm@openssh.com
                   hmac-sha1-etm@openssh.com
                   hmac-sha1-96-etm@openssh.com
                   hmac-sha2-256-etm@openssh.com
                   hmac-sha2-512-etm@openssh.com
                   umac-64-etm@openssh.com
                   umac-128-etm@openssh.com

             The default is:

                   umac-64-etm@openssh.com,umac-128-etm@openssh.com,
                   hmac-sha2-256-etm@openssh.com,hmac-sha2-512-etm@openssh.com,
                   hmac-sha1-etm@openssh.com,
                   umac-64@openssh.com,umac-128@openssh.com,
                   hmac-sha2-256,hmac-sha2-512,hmac-sha1

             The list of available MAC algorithms may also be obtained using "ssh -Q mac".

     MMaattcchh   Introduces a conditional block.  If all of the criteria on the MMaattcchh line are satis‐
             fied, the keywords on the following lines override those set in the global section
             of the config file, until either another MMaattcchh line or the end of the file.  If a
             keyword appears in multiple MMaattcchh blocks that are satisfied, only the first instance
             of the keyword is applied.

             The arguments to MMaattcchh are one or more criteria-pattern pairs or the single token
             AAllll which matches all criteria.  The available criteria are UUsseerr, GGrroouupp, HHoosstt,
             LLooccaallAAddddrreessss, LLooccaallPPoorrtt, and AAddddrreessss.

             The match patterns may consist of single entries or comma-separated lists and may
             use the wildcard and negation operators described in the _P_A_T_T_E_R_N_S section of
             ssh_config(5).

             The patterns in an AAddddrreessss criteria may additionally contain addresses to match in
             CIDR address/masklen format, such as 192.0.2.0/24 or 2001:db8::/32.  Note that the
             mask length provided must be consistent with the address - it is an error to specify
             a mask length that is too long for the address or one with bits set in this host
             portion of the address.  For example, 192.0.2.0/33 and 192.0.2.0/8, respectively.

             Only a subset of keywords may be used on the lines following a MMaattcchh keyword.
             Available keywords are AAcccceeppttEEnnvv, AAlllloowwAAggeennttFFoorrwwaarrddiinngg, AAlllloowwGGrroouuppss,
             AAlllloowwSSttrreeaammLLooccaallFFoorrwwaarrddiinngg, AAlllloowwTTccppFFoorrwwaarrddiinngg, AAlllloowwUUsseerrss, AAuutthheennttiiccaattiioonnMMeetthhooddss,
             AAuutthhoorriizzeeddKKeeyyssCCoommmmaanndd, AAuutthhoorriizzeeddKKeeyyssCCoommmmaannddUUsseerr, AAuutthhoorriizzeeddKKeeyyssFFiillee,
             AAuutthhoorriizzeeddPPrriinncciippaallssCCoommmmaanndd, AAuutthhoorriizzeeddPPrriinncciippaallssCCoommmmaannddUUsseerr,
             AAuutthhoorriizzeeddPPrriinncciippaallssFFiillee, BBaannnneerr, CCAASSiiggnnaattuurreeAAllggoorriitthhmmss, CChhrroooottDDiirreeccttoorryy,
             CClliieennttAAlliivveeCCoouunnttMMaaxx, CClliieennttAAlliivveeIInntteerrvvaall, DDeennyyGGrroouuppss, DDeennyyUUsseerrss, DDiissaabblleeFFoorrwwaarrddiinngg,
             EExxppoosseeAAuutthhIInnffoo, FFoorrcceeCCoommmmaanndd, GGaatteewwaayyPPoorrttss, GGSSSSAAPPIIAAuutthheennttiiccaattiioonn,
             HHoossttbbaasseeddAAcccceepptteeddAAllggoorriitthhmmss, HHoossttbbaasseeddAAuutthheennttiiccaattiioonn,
             HHoossttbbaasseeddUUsseessNNaammeeFFrroommPPaacckkeettOOnnllyy, IIggnnoorreeRRhhoossttss, IInncclluuddee, IIPPQQooSS,
             KKbbddIInntteerraaccttiivveeAAuutthheennttiiccaattiioonn, KKeerrbbeerroossAAuutthheennttiiccaattiioonn, LLooggLLeevveell, MMaaxxAAuutthhTTrriieess,
             MMaaxxSSeessssiioonnss, PPaasssswwoorrddAAuutthheennttiiccaattiioonn, PPeerrmmiittEEmmppttyyPPaasssswwoorrddss, PPeerrmmiittLLiisstteenn, PPeerrmmiittOOppeenn,
             PPeerrmmiittRRoooottLLooggiinn, PPeerrmmiittTTTTYY, PPeerrmmiittTTuunnnneell, PPeerrmmiittUUsseerrRRCC, PPuubbkkeeyyAAcccceepptteeddAAllggoorriitthhmmss,
             PPuubbkkeeyyAAuutthheennttiiccaattiioonn, PPuubbkkeeyyAAuutthhOOppttiioonnss, RReekkeeyyLLiimmiitt, RReevvookkeeddKKeeyyss, SSeettEEnnvv,
             SSttrreeaammLLooccaallBBiinnddMMaasskk, SSttrreeaammLLooccaallBBiinnddUUnnlliinnkk, TTrruusstteeddUUsseerrCCAAKKeeyyss, XX1111DDiissppllaayyOOffffsseett,
             XX1111FFoorrwwaarrddiinngg and XX1111UUsseeLLooccaallhhoosstt.

     MMaaxxAAuutthhTTrriieess
             Specifies the maximum number of authentication attempts permitted per connection.
             Once the number of failures reaches half this value, additional failures are logged.
             The default is 6.

     MMaaxxSSeessssiioonnss
             Specifies the maximum number of open shell, login or subsystem (e.g. sftp) sessions
             permitted per network connection.  Multiple sessions may be established by clients
             that support connection multiplexing.  Setting MMaaxxSSeessssiioonnss to 1 will effectively
             disable session multiplexing, whereas setting it to 0 will prevent all shell, login
             and subsystem sessions while still permitting forwarding.  The default is 10.

     MMaaxxSSttaarrttuuppss
             Specifies the maximum number of concurrent unauthenticated connections to the SSH
             daemon.  Additional connections will be dropped until authentication succeeds or the
             LLooggiinnGGrraacceeTTiimmee expires for a connection.  The default is 10:30:100.

             Alternatively, random early drop can be enabled by specifying the three colon sepa‐
             rated values start:rate:full (e.g. "10:30:60").  sshd(8) will refuse connection at‐
             tempts with a probability of rate/100 (30%) if there are currently start (10) unau‐
             thenticated connections.  The probability increases linearly and all connection at‐
             tempts are refused if the number of unauthenticated connections reaches full (60).

     MMoodduulliiFFiillee
             Specifies the moduli(5) file that contains the Diffie-Hellman groups used for the
             “diffie-hellman-group-exchange-sha1” and “diffie-hellman-group-exchange-sha256” key
             exchange methods.  The default is _/_e_t_c_/_s_s_h_/_m_o_d_u_l_i.

     PPaasssswwoorrddAAuutthheennttiiccaattiioonn
             Specifies whether password authentication is allowed.  The default is yyeess.

     PPeerrmmiittEEmmppttyyPPaasssswwoorrddss
             When password authentication is allowed, it specifies whether the server allows lo‐
             gin to accounts with empty password strings.  The default is nnoo.

     PPeerrmmiittLLiisstteenn
             Specifies the addresses/ports on which a remote TCP port forwarding may listen.  The
             listen specification must be one of the following forms:

                   PPeerrmmiittLLiisstteenn _p_o_r_t
                   PPeerrmmiittLLiisstteenn _h_o_s_t:_p_o_r_t

             Multiple permissions may be specified by separating them with whitespace.  An argu‐
             ment of aannyy can be used to remove all restrictions and permit any listen requests.
             An argument of nnoonnee can be used to prohibit all listen requests.  The host name may
             contain wildcards as described in the PATTERNS section in ssh_config(5).  The wild‐
             card ‘*’ can also be used in place of a port number to allow all ports.  By default
             all port forwarding listen requests are permitted.  Note that the GGaatteewwaayyPPoorrttss op‐
             tion may further restrict which addresses may be listened on.  Note also that ssh(1)
             will request a listen host of “localhost” if no listen host was specifically re‐
             quested, and this name is treated differently to explicit localhost addresses of
             “127.0.0.1” and “::1”.

     PPeerrmmiittOOppeenn
             Specifies the destinations to which TCP port forwarding is permitted.  The forward‐
             ing specification must be one of the following forms:

                   PPeerrmmiittOOppeenn _h_o_s_t:_p_o_r_t
                   PPeerrmmiittOOppeenn _I_P_v_4___a_d_d_r:_p_o_r_t
                   PPeerrmmiittOOppeenn _[_I_P_v_6___a_d_d_r_]:_p_o_r_t

             Multiple forwards may be specified by separating them with whitespace.  An argument
             of aannyy can be used to remove all restrictions and permit any forwarding requests.
             An argument of nnoonnee can be used to prohibit all forwarding requests.  The wildcard
             ‘*’ can be used for host or port to allow all hosts or ports respectively.  Other‐
             wise, no pattern matching or address lookups are performed on supplied names.  By
             default all port forwarding requests are permitted.

     PPeerrmmiittRRoooottLLooggiinn
             Specifies whether root can log in using ssh(1).  The argument must be yyeess,
             pprroohhiibbiitt--ppaasssswwoorrdd, ffoorrcceedd--ccoommmmaannddss--oonnllyy, or nnoo.  The default is pprroohhiibbiitt--ppaasssswwoorrdd.

             If this option is set to pprroohhiibbiitt--ppaasssswwoorrdd (or its deprecated alias,
             wwiitthhoouutt--ppaasssswwoorrdd), password and keyboard-interactive authentication are disabled for
             root.

             If this option is set to ffoorrcceedd--ccoommmmaannddss--oonnllyy, root login with public key authenti‐
             cation will be allowed, but only if the _c_o_m_m_a_n_d option has been specified (which may
             be useful for taking remote backups even if root login is normally not allowed).
             All other authentication methods are disabled for root.

             If this option is set to nnoo, root is not allowed to log in.

     PPeerrmmiittTTTTYY
             Specifies whether pty(4) allocation is permitted.  The default is yyeess.

     PPeerrmmiittTTuunnnneell
             Specifies whether tun(4) device forwarding is allowed.  The argument must be yyeess,
             ppooiinntt--ttoo--ppooiinntt (layer 3), eetthheerrnneett (layer 2), or nnoo.  Specifying yyeess permits both
             ppooiinntt--ttoo--ppooiinntt and eetthheerrnneett.  The default is nnoo.

             Independent of this setting, the permissions of the selected tun(4) device must al‐
             low access to the user.

     PPeerrmmiittUUsseerrEEnnvviirroonnmmeenntt
             Specifies whether _~_/_._s_s_h_/_e_n_v_i_r_o_n_m_e_n_t and eennvviirroonnmmeenntt== options in
             _~_/_._s_s_h_/_a_u_t_h_o_r_i_z_e_d___k_e_y_s are processed by sshd(8).  Valid options are yyeess, nnoo or a
             pattern-list specifying which environment variable names to accept (for example
             "LANG,LC_*").  The default is nnoo.  Enabling environment processing may enable users
             to bypass access restrictions in some configurations using mechanisms such as
             LD_PRELOAD.

     PPeerrmmiittUUsseerrRRCC
             Specifies whether any _~_/_._s_s_h_/_r_c file is executed.  The default is yyeess.

     PPeerrSSoouurrcceeMMaaxxSSttaarrttuuppss
             Specifies the number of unauthenticated connections allowed from a given source ad‐
             dress, or “none” if there is no limit.  This limit is applied in addition to
             MMaaxxSSttaarrttuuppss, whichever is lower.  The default is nnoonnee.

     PPeerrSSoouurrcceeNNeettBBlloocckkSSiizzee
             Specifies the number of bits of source address that are grouped together for the
             purposes of applying PerSourceMaxStartups limits.  Values for IPv4 and optionally
             IPv6 may be specified, separated by a colon.  The default is 3322::112288, which means
             each address is considered individually.

     PPiiddFFiillee
             Specifies the file that contains the process ID of the SSH daemon, or nnoonnee to not
             write one.  The default is _/_r_u_n_/_s_s_h_d_._p_i_d.

     PPoorrtt    Specifies the port number that sshd(8) listens on.  The default is 22.  Multiple op‐
             tions of this type are permitted.  See also LLiisstteennAAddddrreessss.

     PPrriinnttLLaassttLLoogg
             Specifies whether sshd(8) should print the date and time of the last user login when
             a user logs in interactively.  The default is yyeess.

     PPrriinnttMMoottdd
             Specifies whether sshd(8) should print _/_e_t_c_/_m_o_t_d when a user logs in interactively.
             (On some systems it is also printed by the shell, _/_e_t_c_/_p_r_o_f_i_l_e, or equivalent.)  The
             default is yyeess.

     PPuubbkkeeyyAAcccceepptteeddAAllggoorriitthhmmss
             Specifies the signature algorithms that will be accepted for public key authentica‐
             tion as a list of comma-separated patterns.  Alternately if the specified list be‐
             gins with a ‘+’ character, then the specified algorithms will be appended to the de‐
             fault set instead of replacing them.  If the specified list begins with a ‘-’ char‐
             acter, then the specified algorithms (including wildcards) will be removed from the
             default set instead of replacing them.  If the specified list begins with a ‘^’
             character, then the specified algorithms will be placed at the head of the default
             set.  The default for this option is:

                ssh-ed25519-cert-v01@openssh.com,
                ecdsa-sha2-nistp256-cert-v01@openssh.com,
                ecdsa-sha2-nistp384-cert-v01@openssh.com,
                ecdsa-sha2-nistp521-cert-v01@openssh.com,
                sk-ssh-ed25519-cert-v01@openssh.com,
                sk-ecdsa-sha2-nistp256-cert-v01@openssh.com,
                rsa-sha2-512-cert-v01@openssh.com,
                rsa-sha2-256-cert-v01@openssh.com,
                ssh-ed25519,
                ecdsa-sha2-nistp256,ecdsa-sha2-nistp384,ecdsa-sha2-nistp521,
                sk-ssh-ed25519@openssh.com,
                sk-ecdsa-sha2-nistp256@openssh.com,
                rsa-sha2-512,rsa-sha2-256

             The list of available signature algorithms may also be obtained using "ssh -Q
             PubkeyAcceptedAlgorithms".

     PPuubbkkeeyyAAuutthhOOppttiioonnss
             Sets one or more public key authentication options.  The supported keywords are:
             nnoonnee (the default; indicating no additional options are enabled), ttoouucchh--rreeqquuiirreedd and
             vveerriiffyy--rreeqquuiirreedd.

             The ttoouucchh--rreeqquuiirreedd option causes public key authentication using a FIDO authentica‐
             tor algorithm (i.e. eeccddssaa--sskk or eedd2255551199--sskk) to always require the signature to at‐
             test that a physically present user explicitly confirmed the authentication (usually
             by touching the authenticator).  By default, sshd(8) requires user presence unless
             overridden with an authorized_keys option.  The ttoouucchh--rreeqquuiirreedd flag disables this
             override.

             The vveerriiffyy--rreeqquuiirreedd option requires a FIDO key signature attest that the user was
             verified, e.g. via a PIN.

             Neither the ttoouucchh--rreeqquuiirreedd or vveerriiffyy--rreeqquuiirreedd options have any effect for other,
             non-FIDO, public key types.

     PPuubbkkeeyyAAuutthheennttiiccaattiioonn
             Specifies whether public key authentication is allowed.  The default is yyeess.

     RReekkeeyyLLiimmiitt
             Specifies the maximum amount of data that may be transmitted before the session key
             is renegotiated, optionally followed by a maximum amount of time that may pass be‐
             fore the session key is renegotiated.  The first argument is specified in bytes and
             may have a suffix of ‘K’, ‘M’, or ‘G’ to indicate Kilobytes, Megabytes, or Giga‐
             bytes, respectively.  The default is between ‘1G’ and ‘4G’, depending on the cipher.
             The optional second value is specified in seconds and may use any of the units docu‐
             mented in the _T_I_M_E _F_O_R_M_A_T_S section.  The default value for RReekkeeyyLLiimmiitt is ddeeffaauulltt
             nnoonnee, which means that rekeying is performed after the cipher's default amount of
             data has been sent or received and no time based rekeying is done.

     RReevvookkeeddKKeeyyss
             Specifies revoked public keys file, or nnoonnee to not use one.  Keys listed in this
             file will be refused for public key authentication.  Note that if this file is not
             readable, then public key authentication will be refused for all users.  Keys may be
             specified as a text file, listing one public key per line, or as an OpenSSH Key Re‐
             vocation List (KRL) as generated by ssh-keygen(1).  For more information on KRLs,
             see the KEY REVOCATION LISTS section in ssh-keygen(1).

     SSeeccuurriittyyKKeeyyPPrroovviiddeerr
             Specifies a path to a library that will be used when loading FIDO authenticator-
             hosted keys, overriding the default of using the built-in USB HID support.

     SSeettEEnnvv  Specifies one or more environment variables to set in child sessions started by
             sshd(8) as “NAME=VALUE”.  The environment value may be quoted (e.g. if it contains
             whitespace characters).  Environment variables set by SSeettEEnnvv override the default
             environment and any variables specified by the user via AAcccceeppttEEnnvv or
             PPeerrmmiittUUsseerrEEnnvviirroonnmmeenntt.

     SSttrreeaammLLooccaallBBiinnddMMaasskk
             Sets the octal file creation mode mask (umask) used when creating a Unix-domain
             socket file for local or remote port forwarding.  This option is only used for port
             forwarding to a Unix-domain socket file.

             The default value is 0177, which creates a Unix-domain socket file that is readable
             and writable only by the owner.  Note that not all operating systems honor the file
             mode on Unix-domain socket files.

     SSttrreeaammLLooccaallBBiinnddUUnnlliinnkk
             Specifies whether to remove an existing Unix-domain socket file for local or remote
             port forwarding before creating a new one.  If the socket file already exists and
             SSttrreeaammLLooccaallBBiinnddUUnnlliinnkk is not enabled, sssshhdd will be unable to forward the port to the
             Unix-domain socket file.  This option is only used for port forwarding to a Unix-do‐
             main socket file.

             The argument must be yyeess or nnoo.  The default is nnoo.

     SSttrriiccttMMooddeess
             Specifies whether sshd(8) should check file modes and ownership of the user's files
             and home directory before accepting login.  This is normally desirable because
             novices sometimes accidentally leave their directory or files world-writable.  The
             default is yyeess.  Note that this does not apply to CChhrroooottDDiirreeccttoorryy, whose permissions
             and ownership are checked unconditionally.

     SSuubbssyysstteemm
             Configures an external subsystem (e.g. file transfer daemon).  Arguments should be a
             subsystem name and a command (with optional arguments) to execute upon subsystem re‐
             quest.

             The command ssffttpp--sseerrvveerr implements the SFTP file transfer subsystem.

             Alternately the name iinntteerrnnaall--ssffttpp implements an in-process SFTP server.  This may
             simplify configurations using CChhrroooottDDiirreeccttoorryy to force a different filesystem root
             on clients.

             By default no subsystems are defined.

     SSyyssllooggFFaacciilliittyy
             Gives the facility code that is used when logging messages from sshd(8).  The possi‐
             ble values are: DAEMON, USER, AUTH, LOCAL0, LOCAL1, LOCAL2, LOCAL3, LOCAL4, LOCAL5,
             LOCAL6, LOCAL7.  The default is AUTH.

     TTCCPPKKeeeeppAAlliivvee
             Specifies whether the system should send TCP keepalive messages to the other side.
             If they are sent, death of the connection or crash of one of the machines will be
             properly noticed.  However, this means that connections will die if the route is
             down temporarily, and some people find it annoying.  On the other hand, if TCP
             keepalives are not sent, sessions may hang indefinitely on the server, leaving
             "ghost" users and consuming server resources.

             The default is yyeess (to send TCP keepalive messages), and the server will notice if
             the network goes down or the client host crashes.  This avoids infinitely hanging
             sessions.

             To disable TCP keepalive messages, the value should be set to nnoo.

             This option was formerly called KKeeeeppAAlliivvee.

     TTrruusstteeddUUsseerrCCAAKKeeyyss
             Specifies a file containing public keys of certificate authorities that are trusted
             to sign user certificates for authentication, or nnoonnee to not use one.  Keys are
             listed one per line; empty lines and comments starting with ‘#’ are allowed.  If a
             certificate is presented for authentication and has its signing CA key listed in
             this file, then it may be used for authentication for any user listed in the cer‐
             tificate's principals list.  Note that certificates that lack a list of principals
             will not be permitted for authentication using TTrruusstteeddUUsseerrCCAAKKeeyyss.  For more details
             on certificates, see the CERTIFICATES section in ssh-keygen(1).

     UUsseeDDNNSS  Specifies whether sshd(8) should look up the remote host name, and to check that the
             resolved host name for the remote IP address maps back to the very same IP address.

             If this option is set to nnoo (the default) then only addresses and not host names may
             be used in _~_/_._s_s_h_/_a_u_t_h_o_r_i_z_e_d___k_e_y_s ffrroomm and sssshhdd__ccoonnffiigg MMaattcchh HHoosstt directives.

     UUsseePPAAMM  Enables the Pluggable Authentication Module interface.  If set to yyeess this will en‐
             able PAM authentication using KKbbddIInntteerraaccttiivveeAAuutthheennttiiccaattiioonn and
             PPaasssswwoorrddAAuutthheennttiiccaattiioonn in addition to PAM account and session module processing for
             all authentication types.

             Because PAM keyboard-interactive authentication usually serves an equivalent role to
             password authentication, you should disable either PPaasssswwoorrddAAuutthheennttiiccaattiioonn or
             KKbbddIInntteerraaccttiivveeAAuutthheennttiiccaattiioonn.

             If UUsseePPAAMM is enabled, you will not be able to run sshd(8) as a non-root user.  The
             default is nnoo.

     VVeerrssiioonnAAddddeenndduumm
             Optionally specifies additional text to append to the SSH protocol banner sent by
             the server upon connection.  The default is nnoonnee.

     XX1111DDiissppllaayyOOffffsseett
             Specifies the first display number available for sshd(8)'s X11 forwarding.  This
             prevents sshd from interfering with real X11 servers.  The default is 10.

     XX1111FFoorrwwaarrddiinngg
             Specifies whether X11 forwarding is permitted.  The argument must be yyeess or nnoo.  The
             default is nnoo.

             When X11 forwarding is enabled, there may be additional exposure to the server and
             to client displays if the sshd(8) proxy display is configured to listen on the wild‐
             card address (see XX1111UUsseeLLooccaallhhoosstt), though this is not the default.  Additionally,
             the authentication spoofing and authentication data verification and substitution
             occur on the client side.  The security risk of using X11 forwarding is that the
             client's X11 display server may be exposed to attack when the SSH client requests
             forwarding (see the warnings for FFoorrwwaarrddXX1111 in ssh_config(5)).  A system administra‐
             tor may have a stance in which they want to protect clients that may expose them‐
             selves to attack by unwittingly requesting X11 forwarding, which can warrant a nnoo
             setting.

             Note that disabling X11 forwarding does not prevent users from forwarding X11 traf‐
             fic, as users can always install their own forwarders.

     XX1111UUsseeLLooccaallhhoosstt
             Specifies whether sshd(8) should bind the X11 forwarding server to the loopback ad‐
             dress or to the wildcard address.  By default, sshd binds the forwarding server to
             the loopback address and sets the hostname part of the DISPLAY environment variable
             to llooccaallhhoosstt.  This prevents remote hosts from connecting to the proxy display.
             However, some older X11 clients may not function with this configuration.
             XX1111UUsseeLLooccaallhhoosstt may be set to nnoo to specify that the forwarding server should be
             bound to the wildcard address.  The argument must be yyeess or nnoo.  The default is yyeess.

     XXAAuutthhLLooccaattiioonn
             Specifies the full pathname of the xauth(1) program, or nnoonnee to not use one.  The
             default is _/_u_s_r_/_b_i_n_/_x_a_u_t_h.

TTIIMMEE FFOORRMMAATTSS
     sshd(8) command-line arguments and configuration file options that specify time may be ex‐
     pressed using a sequence of the form: _t_i_m_e[_q_u_a_l_i_f_i_e_r], where _t_i_m_e is a positive integer
     value and _q_u_a_l_i_f_i_e_r is one of the following:

           ⟨nnoonnee⟩  seconds
           ss | SS   seconds
           mm | MM   minutes
           hh | HH   hours
           dd | DD   days
           ww | WW   weeks

     Each member of the sequence is added together to calculate the total time value.

     Time format examples:

           600     600 seconds (10 minutes)
           10m     10 minutes
           1h30m   1 hour 30 minutes (90 minutes)

TTOOKKEENNSS
     Arguments to some keywords can make use of tokens, which are expanded at runtime:

           %%    A literal ‘%’.
           %F    The fingerprint of the CA key.
           %f    The fingerprint of the key or certificate.
           %h    The home directory of the user.
           %i    The key ID in the certificate.
           %K    The base64-encoded CA key.
           %k    The base64-encoded key or certificate for authentication.
           %s    The serial number of the certificate.
           %T    The type of the CA key.
           %t    The key or certificate type.
           %U    The numeric user ID of the target user.
           %u    The username.

     AAuutthhoorriizzeeddKKeeyyssCCoommmmaanndd accepts the tokens %%, %f, %h, %k, %t, %U, and %u.

     AAuutthhoorriizzeeddKKeeyyssFFiillee accepts the tokens %%, %h, %U, and %u.

     AAuutthhoorriizzeeddPPrriinncciippaallssCCoommmmaanndd accepts the tokens %%, %F, %f, %h, %i, %K, %k, %s, %T, %t, %U,
     and %u.

     AAuutthhoorriizzeeddPPrriinncciippaallssFFiillee accepts the tokens %%, %h, %U, and %u.

     CChhrroooottDDiirreeccttoorryy accepts the tokens %%, %h, %U, and %u.

FFIILLEESS
     /etc/ssh/sshd_config
             Contains configuration data for sshd(8).  This file should be writable by root only,
             but it is recommended (though not necessary) that it be world-readable.

SSEEEE AALLSSOO
     sftp-server(8), sshd(8)

AAUUTTHHOORRSS
     OpenSSH is a derivative of the original and free ssh 1.2.12 release by Tatu Ylonen.  Aaron
     Campbell, Bob Beck, Markus Friedl, Niels Provos, Theo de Raadt and Dug Song removed many
     bugs, re-added newer features and created OpenSSH.  Markus Friedl contributed the support
     for SSH protocol versions 1.5 and 2.0.  Niels Provos and Markus Friedl contributed support
     for privilege separation.

BSD                                      December 4, 2021                                     BSD
