Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EpUhE-0003IG-IJ for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Dec 2005 09:57:44 -0800
Received: from mail.scgiservices.com ([198.107.3.67])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EpUhB-0000mS-Ep
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Dec 2005 09:57:44 -0800
Received: from localhost (localhost [127.0.0.1])
	by mail.scgiservices.com (Postfix) with ESMTP id 10184204AB
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 22 Dec 2005 09:57:40 -0800 (PST)
Received: from mail.scgiservices.com ([127.0.0.1])
	by localhost (mail [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 02043-01 for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 22 Dec 2005 09:57:36 -0800 (PST)
Received: from SCG2 (c-67-160-154-69.hsd1.or.comcast.net [67.160.154.69])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail.scgiservices.com (Postfix) with ESMTP id 16891200A6
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 22 Dec 2005 09:57:35 -0800 (PST)
From: "Anthony Brock" <brocka@sterlingcgi.com>
Subject: RE: [uml-devel] Re: pcap cross-linking [PATCH]
Message-ID: <CGEGKKNGBDKPCKOKKGFEIEBACDAA.brocka@sterlingcgi.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_000A_01C606DE.221BEE40"
In-Reply-To: <200512211913.18433.blaisorblade@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 22 Dec 2005 09:57:35 -0800
To: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

------=_NextPart_000_000A_01C606DE.221BEE40
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

I don't think the attachment made it into the email. However, I am attaching
one that we've used with good success. It allows us to also specify a "nice"
level for the UML kernel in addition to the chroot-setuid.

Tony


> -----Original Message-----
> From: user-mode-linux-devel-admin@lists.sourceforge.net
> [mailto:user-mode-linux-devel-admin@lists.sourceforge.net]On Behalf Of
> Blaisorblade
> Sent: Wednesday, December 21, 2005 10:13 AM
> To: user-mode-linux-devel@lists.sourceforge.net
> Cc: Rob Landley; Antoine Martin
> Subject: Re: [uml-devel] Re: pcap cross-linking [PATCH]
>
>
> Forgot to say one thing - the attachment is a minimal
> chroot-setuid C program
> written by Jeff Dike for his book - it's minimal and trivial to verify.
>
> --
> Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
> Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ
> 215621894)
> http://www.user-mode-linux.org/~blaisorblade
>
>
> ___________________________________
> Yahoo! Messenger: chiamate gratuite in tutto il mondo
> http://it.messenger.yahoo.com
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep
> through log files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>

------=_NextPart_000_000A_01C606DE.221BEE40
Content-Type: application/octet-stream;
	name="chrootuidgid.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="chrootuidgid.c"

#include <unistd.h>=0A=
#include <pwd.h>=0A=
#include <sys/types.h>=0A=
#include <sys/param.h>=0A=
#include <errno.h>=0A=
#include <stdio.h>=0A=
#include <stdlib.h>=0A=
=0A=
#define TMP_PATH "/dev/shm"=0A=
#define PATH "PATH"=0A=
int main(int ac, char **av)=0A=
{=0A=
	char *param[ac+1];=0A=
	char *uname =3D NULL;=0A=
	char *chroot_dir =3D NULL;=0A=
	char *path =3D NULL;=0A=
	struct passwd *userinfo;=0A=
	int c, i;=0A=
	int nice_val =3D 0;=0A=
	uid_t uid =3D 0;=0A=
	gid_t gid =3D 0;=0A=
=0A=
	opterr =3D 0;=0A=
=0A=
	while ((c =3D getopt(ac, av, "+u:n:p:")) !=3D -1)=0A=
		switch (c)=0A=
		{=0A=
			case 'u':=0A=
				uname =3D optarg;=0A=
				break;=0A=
			case 'n':=0A=
				nice_val =3D atoi(optarg);=0A=
				break;=0A=
			case 'p':=0A=
				chroot_dir =3D optarg;=0A=
				break;=0A=
			case '?':=0A=
				if (isprint (optopt))=0A=
					fprintf (stderr, "Unknown option `-%c'.\n", optopt);=0A=
				else=0A=
					fprintf (stderr,=0A=
						 "Unknown option character `\\x%x'.\n",=0A=
						  optopt);=0A=
				return 1;=0A=
			default:=0A=
				abort();=0A=
		}=0A=
=0A=
	if ((uname !=3D NULL) && (chroot_dir !=3D NULL))=0A=
	{=0A=
		if ((userinfo =3D getpwnam(uname)) !=3D NULL)=0A=
		{=0A=
			uid =3D userinfo->pw_uid;=0A=
			gid =3D userinfo->pw_gid;=0A=
=0A=
			// Adjust the process priority by the requested "nice" value=0A=
			if(nice(nice_val) =3D=3D -1)=0A=
			{=0A=
				fprintf(stderr, "error changing 'nice' value to %i: %s\n", nice_val, =
strerror(errno));=0A=
				return 1;=0A=
			}=0A=
=0A=
			// Abort if we were passed user "root"=0A=
			if (uid =3D=3D 0)=0A=
			{=0A=
				fprintf (stderr, "Specified account must NOT be root!\n");=0A=
				return 1;=0A=
			}=0A=
=0A=
			// Clear any existing environment=0A=
			path =3D getenv(PATH);=0A=
			if (clearenv())=0A=
			{=0A=
				fprintf(stderr, "WARNING: unable to clear environment!\n");=0A=
			}=0A=
=0A=
			// Setup the command environment=0A=
			setenv("HOME", userinfo->pw_dir, 1);=0A=
			setenv(PATH, path, 1);=0A=
			setenv("TMP", TMP_PATH, 1);=0A=
			setenv("USER", userinfo->pw_name, 1);=0A=
=0A=
			// Our first parameter should be the command we're to execute=0A=
			// Therefore, we assign this to element '0' of our parameters to pass=0A=
			for (i =3D 0, c =3D optind; c < ac; i++, c++)=0A=
			{=0A=
				param[i] =3D av[c];=0A=
			}=0A=
=0A=
			// Abort if we have not other parameters=0A=
			if (i =3D=3D 0)=0A=
			{=0A=
				fprintf (stderr, "You must specify a command to execute!\n");=0A=
				return 1;=0A=
			}=0A=
=0A=
			// The final element in the array MUST be a NULL pointer=0A=
			param[i] =3D NULL;=0A=
=0A=
			// First, we need to CHDIR to the CHROOT directory=0A=
			if(chdir(chroot_dir) =3D=3D -1)=0A=
			{=0A=
				fprintf(stderr, "chdir to '%s' failed: %s\n", chroot_dir, =
strerror(errno));=0A=
				return 3;=0A=
			}=0A=
=0A=
			// Next, we need to CHROOT ourselves (while we're still root)=0A=
			if(chroot(chroot_dir) =3D=3D -1)=0A=
			{=0A=
				fprintf(stderr, "chroot to '%s' failed: %s\n", chroot_dir, =
strerror(errno));=0A=
				return 3;=0A=
			}=0A=
=0A=
			// Now CHDIR to the accounts home directory. This is a non-fatal =
error.=0A=
			if(chdir(userinfo->pw_dir) =3D=3D -1)=0A=
			{=0A=
				fprintf(stderr, "WARNING: chdir to home directory '%s' failed: =
%s\n", userinfo->pw_dir, strerror(errno));=0A=
			}=0A=
=0A=
			if(setregid(gid, gid) =3D=3D -1)=0A=
			{=0A=
				fprintf(stderr, "setregid to gid %i failed: %s\n", gid, =
strerror(errno));=0A=
				return 3;=0A=
			}=0A=
=0A=
			if(setreuid(uid, uid) =3D=3D -1)=0A=
			{=0A=
				fprintf(stderr, "setreuid to uid %i failed: %s\n", uid, =
strerror(errno));=0A=
				return 3;=0A=
			}=0A=
=0A=
			if(execvp(param[0], param) =3D=3D -1)=0A=
			{=0A=
				fprintf(stderr, "exec for '%s' failed: %s\n", param[0], =
strerror(errno));=0A=
				return 4;=0A=
			}=0A=
		}=0A=
		else=0A=
		{=0A=
			fprintf(stderr, "User '%s' not found\n", uname);=0A=
			return 2;=0A=
		}=0A=
	}=0A=
	else=0A=
	{=0A=
		fprintf(stderr, "You must specify a valid account with the '-u' option =
and a valid chroot path with the '-p' option!\n");=0A=
		return 1;=0A=
	}=0A=
}=0A=

------=_NextPart_000_000A_01C606DE.221BEE40--



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
