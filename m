Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KY1mj-0005pX-Lt for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 Aug 2008 09:52:49 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KY1mi-0008N0-5B
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 Aug 2008 09:52:49 -0700
Date: Tue, 26 Aug 2008 12:52:22 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080826165222.GA18584@c2.user-mode-linux.org>
References: <Pine.LNX.4.64.0808190904200.4551@wrl-59.cs.helsinki.fi>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0808190904200.4551@wrl-59.cs.helsinki.fi>
Subject: Re: [uml-devel] [RFC PATCH] uml: fix double statement if missing
	braces
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@helsinki.fi>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, Aug 19, 2008 at 09:09:16AM +0300, Ilpo J=E4rvinen wrote:
> ...I'm not fully sure what's the intention here, ie., whether
> the return belongs to a block with the assignment or not.

Yes, this is confused, although it just happens to compile to
something sane.  Your patch is fine, but I think the whole thing needs
some more cleanup.  See the patch below.

     	  	    	Jeff

-- =

Work email - jdike at linux dot intel dot com

The testing for the host's TLS support was somewhat confused - notably
in the indentation of a return.

This cleans it up:
	*supports_tls is only set to 0 once
	any error besides EINVAL causes an immediate return, with
*supports_tls equal to 0.

Index: linux-2.6.22/arch/um/os-Linux/sys-i386/tls.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.22.orig/arch/um/os-Linux/sys-i386/tls.c	2007-07-08 19:32:17.0=
00000000 -0400
+++ linux-2.6.22/arch/um/os-Linux/sys-i386/tls.c	2008-08-26 08:19:37.000000=
000 -0400
@@ -15,6 +15,7 @@ void check_host_supports_tls(int *suppor
 	int val[] =3D {GDT_ENTRY_TLS_MIN_I386, GDT_ENTRY_TLS_MIN_X86_64};
 	int i;
 =

+	*supports_tls =3D 0;
 	for (i =3D 0; i < ARRAY_SIZE(val); i++) {
 		user_desc_t info;
 		info.entry_number =3D val[i];
@@ -23,14 +24,9 @@ void check_host_supports_tls(int *suppor
 			*tls_min =3D val[i];
 			*supports_tls =3D 1;
 			return;
-		} else {
-			if (errno =3D=3D EINVAL)
-				continue;
-			else if (errno =3D=3D ENOSYS)
-				*supports_tls =3D 0;
-				return;
 		}
+		if (errno =3D=3D EINVAL)
+			continue;
+		else return;
 	}
-
-	*supports_tls =3D 0;
 }

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
