Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IunHE-0007bN-Nq for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Nov 2007 02:57:53 -0800
Received: from kilimandjaro.dyndns.org ([212.85.147.17])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IunHD-0005N8-2P
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Nov 2007 02:57:52 -0800
Message-ID: <47440E58.5060008@quatravaux.org>
Date: Wed, 21 Nov 2007 11:54:16 +0100
From: Dominique Quatravaux <dominique@quatravaux.org>
MIME-Version: 1.0
References: <4742F40B.1030508@quatravaux.org>
	<20071120170726.GC7211@c2.user-mode-linux.org>
In-Reply-To: <20071120170726.GC7211@c2.user-mode-linux.org>
Subject: Re: [uml-devel] [uml-user] [PATCH] Fixed hostfs tv_usec / tv_nsec
	conversion in 2.6.22.9
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jeff Dike wrote:
>
> Can I get a Signed-off-by: from you?
Sure thing, although I was not planning on asserting copyright on a
grand total of 4 slashes...

- -=-=-=-

- From Dominique Quatravaux <dominique@quatravaux.org>

To convert from tv_nsec to tv_usec, one needs to divide by 1000, not
multiply.

Signed-off-by: Dominique Quatravaux <dominique@quatravaux.org>

- ---

diff --git a/fs/hostfs/hostfs_user.c b/fs/hostfs/hostfs_user.c
- --- a/fs/hostfs/hostfs_user.c
+++ b/fs/hostfs/hostfs_user.c
@@ -262,17 +262,17 @@ int set_attr(const char *file, struct ho
             return err;
 
         times[0].tv_sec = atime_ts.tv_sec;
- -        times[0].tv_usec = atime_ts.tv_nsec * 1000;
+        times[0].tv_usec = atime_ts.tv_nsec / 1000;
         times[1].tv_sec = mtime_ts.tv_sec;
- -        times[1].tv_usec = mtime_ts.tv_nsec * 1000;
+        times[1].tv_usec = mtime_ts.tv_nsec / 1000;
 
         if (attrs->ia_valid & HOSTFS_ATTR_ATIME_SET) {
             times[0].tv_sec = attrs->ia_atime.tv_sec;
- -            times[0].tv_usec = attrs->ia_atime.tv_nsec * 1000;
+            times[0].tv_usec = attrs->ia_atime.tv_nsec / 1000;
         }
         if (attrs->ia_valid & HOSTFS_ATTR_MTIME_SET) {
             times[1].tv_sec = attrs->ia_mtime.tv_sec;
- -            times[1].tv_usec = attrs->ia_mtime.tv_nsec * 1000;
+            times[1].tv_usec = attrs->ia_mtime.tv_nsec / 1000;
         }
 
         if (fd >= 0) {

- --
<< Tout n'y est pas parfait, mais on y honore certainement les
jardiniers >>

            Dominique Quatravaux <dominique@quatravaux.org>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQCVAwUBR0QOWPTYH7KfeIIFAQLaNgQAo/mzyru7m/Iafg57olEQXIy4jMyvJhma
Pd2XC4JKrAIQ0o3ut/IjuYoGatp0vDALsqAfURCKPaSyyy+xxSl5Ihvg0WcbrcSa
jB3ydvweUgiMfcMho6j2zWLUuhMAdlmtprmj1Gy2jfet+5HM9HwlmxzaNB40TeuW
jvSrEvjTHBw=
=YgoE
-----END PGP SIGNATURE-----



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
