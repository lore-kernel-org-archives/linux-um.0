Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <torvalds@linux-foundation.org>) id 1QvJWQ-0005Pb-6A
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Aug 2011 01:41:50 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QvJWP-00044E-DI
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Aug 2011 01:41:50 +0000
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with
	ESMTP id p7M1fbOc031452
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 21 Aug 2011 18:41:38 -0700
Received: by wwj26 with SMTP id 26so1803969wwj.4
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 21 Aug 2011 18:41:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110822011645.GM2203@ZenIV.linux.org.uk>
References: <20110820201406.GF2203@ZenIV.linux.org.uk>
	<4E501F51.9060905@nod.at>
	<CAObL_7FoPHu6AKneswjEmiU4UBjUuKpYahakOaTNXM3=ZCpYaA@mail.gmail.com>
	<CAObL_7H8E1fde-d_Kfjrg2mQ5PdAp9X=fVRTqXJKzzYmQ1vAQQ@mail.gmail.com>
	<20110821063443.GH2203@ZenIV.linux.org.uk>
	<20110821084230.GI2203@ZenIV.linux.org.uk>
	<CAObL_7GXyzAzNjBtgye9BwXLyHm337oBTdjRDjbSPqoKZGWyyA@mail.gmail.com>
	<20110821144352.GJ2203@ZenIV.linux.org.uk>
	<20110821164124.GL2203@ZenIV.linux.org.uk>
	<CAObL_7E1vU8+0UQST6Smf9j40TckTzB=QdY0AuAWo4AX6cs2xg@mail.gmail.com>
	<20110822011645.GM2203@ZenIV.linux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 21 Aug 2011 18:41:16 -0700
Message-ID: <CA+55aFz1jCZGcQ-c6uGN=k8nKDuGoz5g8e+pxpYAg4X_p7=5Mw@mail.gmail.com>
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
Subject: Re: [uml-devel] SYSCALL,
 ptrace and syscall restart breakages (Re: [RFC] weird crap with
 vdso on uml/i386)
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Lutomirski <luto@mit.edu>, user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, mingo@redhat.com, "H. Peter Anvin" <hpa@zytor.com>

On Sun, Aug 21, 2011 at 6:16 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Is that ability a part of userland ABI or are we declaring that hopelessly
> wrong and require to go through the function in vdso32? =A0Linus?

If people are using syscall directly, we're pretty much stuck. No
amount of "that's hopelessly wrong" will ever matter. We don't break
existing binaries.

That said, I'd *hope* that everybody uses the vdso32, simply because
user programs are not supposed to know which CPU they are running on
and if that CPU even *supports* the syscall instruction. In which case
it may be possible that we can play games with the vdso thing. But
that really would be conditional on "nobody ever reports a failure".

But if that's possible, maybe we can increment the RIP by 2 for
'syscall', and slip an "'int 0x80" after the syscall instruction in
the vdso there? Resulting in the same pseudo-solution I suggested for
sysenter...

                          Linus

---------------------------------------------------------------------------=
---
uberSVN's rich system and user administration capabilities and model =

configuration take the hassle out of deploying and managing Subversion and =

the tools developers use with it. Learn more about uberSVN and get a free =

download at:  http://p.sf.net/sfu/wandisco-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

