Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <richard.weinberger@gmail.com>) id 1Q3rlN-0006SV-M8
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Mar 2011 15:20:21 +0000
Received: from mail-iy0-f175.google.com ([209.85.210.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1Q3rlL-0000zr-Dl
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Mar 2011 15:20:21 +0000
Received: by iye7 with SMTP id 7so2999650iye.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 27 Mar 2011 08:20:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110327102305.7569.86213.stgit@zaytsev.su>
References: <20110327102305.7569.86213.stgit@zaytsev.su>
Date: Sun, 27 Mar 2011 17:20:13 +0200
Message-ID: <AANLkTinCW4VUEp6b8Ktj5Wm-141oHdrt3y8TTBeqZWTo@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH] tunctl: Allow non-persitent interfaces
To: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Cc: Jeff Dike <jdike@karaya.com>, user-mode-linux-devel@lists.sourceforge.net

On Sun, Mar 27, 2011 at 12:28 PM, Alexey Zaytsev
<alexey.zaytsev@gmail.com> wrote:
> Signed-off-by: Alexey Zaytsev <alexey.zaytsev@gmail.com>
> ---

Alexey,

> Hello, uml people. Does someone still maintain the uml utilities? You've =
been
> a bit quiet for the last 4 years, but now I've got a patch for you to app=
ly. It's
> handy when you run qemu (or anything else that wants persistent tunnels)
> inside openvz containers:
> http://wiki.openvz.org/VPN_via_the_TUN/TAP_device#The_tunctl_problem
>

Thanks for the patch.
Currently nobody seems to maintain the uml utilities.
I'm doing some work on UML.
Until now no work on uml utilities was needed.

I'll take care of it.

> =A0tunctl/tunctl.c | =A0 39 +++++++++++++++++++++++++++++++--------
> =A01 files changed, 31 insertions(+), 8 deletions(-)
>
> diff --git a/tunctl/tunctl.c b/tunctl/tunctl.c
> index 16e24a2..0eca752 100644
> --- a/tunctl/tunctl.c
> +++ b/tunctl/tunctl.c
> @@ -21,13 +21,16 @@
>
> =A0static void Usage(char *name)
> =A0{
> - =A0fprintf(stderr, "Create: %s [-b] [-u owner] [-g group] [-t device-na=
me] "
> + =A0fprintf(stderr, "Create: %s [-b] [-n [-m]] [-u owner] [-g group] [-t=
 device-name] "
> =A0 =A0 =A0 =A0 =A0"[-f tun-clone-device]\n", name);
> =A0 fprintf(stderr, "Delete: %s -d device-name [-f tun-clone-device]\n\n",
> =A0 =A0 =A0 =A0 =A0name);
> =A0 fprintf(stderr, "The default tun clone device is /dev/net/tun - some =
systems"
> =A0 =A0 =A0 =A0 =A0" use\n/dev/misc/net/tun instead\n\n");
> - =A0fprintf(stderr, "-b will result in brief output (just the device nam=
e)\n");
> + =A0fprintf(stderr, "\t-b will result in brief output (just the device n=
ame)\n");
> + =A0fprintf(stderr, "\t-n will create a non-persistent tunnel, and sleep=
 until killed\n");
> + =A0fprintf(stderr, "\t-m will daemonize before slleeping, only makes se=
nse with -n\n");
> +
> =A0 exit(1);
> =A0}
>
> @@ -38,10 +41,10 @@ int main(int argc, char **argv)
> =A0 struct group *gr;
> =A0 uid_t owner =3D -1;
> =A0 gid_t group =3D -1;
> - =A0int tap_fd, opt, delete =3D 0, brief =3D 0;
> + =A0int tap_fd, opt, delete =3D 0, brief =3D 0, persistent =3D 1, daemon=
ize =3D 0;
> =A0 char *tun =3D "", *file =3D "/dev/net/tun", *name =3D argv[0], *end;
>
> - =A0while((opt =3D getopt(argc, argv, "bd:f:t:u:g:")) > 0){
> + =A0while((opt =3D getopt(argc, argv, "bd:f:t:u:g:nm")) > 0){
> =A0 =A0 switch(opt) {
> =A0 =A0 =A0 case 'b':
> =A0 =A0 =A0 =A0 brief =3D 1;
> @@ -83,6 +86,13 @@ int main(int argc, char **argv)
> =A0 =A0 =A0 case 't':
> =A0 =A0 =A0 =A0 tun =3D optarg;
> =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0case 'n':
> + =A0 =A0 =A0 =A0persistent =3D 0;
> + =A0 =A0 =A0 =A0break;
> + =A0 =A0 =A0case 'm':
> + =A0 =A0 =A0 =A0daemonize =3D 1;
> + =A0 =A0 =A0 =A0break;
> +
> =A0 =A0 =A0 case 'h':
> =A0 =A0 =A0 default:
> =A0 =A0 =A0 =A0 Usage(name);
> @@ -136,21 +146,34 @@ int main(int argc, char **argv)
> =A0 =A0 =A0 }
> =A0 =A0 }
>
> - =A0 =A0if(ioctl(tap_fd, TUNSETPERSIST, 1) < 0){
> - =A0 =A0 =A0perror("enabling TUNSETPERSIST");
> - =A0 =A0 =A0exit(1);
> + =A0 =A0if (persistent) {
> + =A0 =A0 =A0if(ioctl(tap_fd, TUNSETPERSIST, 1) < 0){
> + =A0 =A0 =A0 =A0perror("enabling TUNSETPERSIST");
> + =A0 =A0 =A0 =A0exit(1);
> + =A0 =A0 =A0}
> =A0 =A0 }
>
> =A0 =A0 if(brief)
> =A0 =A0 =A0 printf("%s\n", ifr.ifr_name);
> =A0 =A0 else {
> - =A0 =A0 =A0printf("Set '%s' persistent and owned by", ifr.ifr_name);
> + =A0 =A0 =A0if (persistent) {
> + =A0 =A0 =A0 =A0printf("Set '%s' persistent and owned by", ifr.ifr_name);
> + =A0 =A0 =A0} else {
> + =A0 =A0 =A0 =A0printf("(%u) Sleeping on non-persistent '%s' owned by",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0getpid(), ifr.ifr_name);
> + =A0 =A0 =A0}
> =A0 =A0 =A0 if(owner !=3D -1)
> =A0 =A0 =A0 =A0 =A0 printf(" uid %d", owner);
> =A0 =A0 =A0 if(group !=3D -1)
> =A0 =A0 =A0 =A0 =A0 printf(" gid %d", group);
> =A0 =A0 =A0 printf("\n");
> =A0 =A0 }
> +
> + =A0 =A0if (!persistent) {
> + =A0 =A0 =A0 =A0 =A0if (daemonize)
> + =A0 =A0 =A0 =A0 =A0 =A0daemon(1, 1);
> + =A0 =A0 =A0 =A0 =A0pause();
> + =A0 =A0}
> =A0 }
> =A0 return(0);
> =A0}
>
>
> -------------------------------------------------------------------------=
-----
> Enable your software for Intel(R) Active Management Technology to meet the
> growing manageability and security demands of your customers. Businesses
> are taking advantage of Intel(R) vPro (TM) technology - will your software
> be a part of the solution? Download the Intel(R) Manageability Checker
> today! http://p.sf.net/sfu/intel-dev2devmar
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>

-- =

Thanks,
//richard

---------------------------------------------------------------------------=
---
Enable your software for Intel(R) Active Management Technology to meet the
growing manageability and security demands of your customers. Businesses
are taking advantage of Intel(R) vPro (TM) technology - will your software =

be a part of the solution? Download the Intel(R) Manageability Checker =

today! http://p.sf.net/sfu/intel-dev2devmar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

