Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <amluto@gmail.com>) id 1QvUeU-0001X6-1n
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Aug 2011 13:34:54 +0000
Received: from mail-gy0-f175.google.com ([209.85.160.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1QvUeT-0002NG-7L
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Aug 2011 13:34:53 +0000
Received: by gyg4 with SMTP id 4so4187128gyg.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 22 Aug 2011 06:34:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110822095336.GB25949@kernel.org>
References: <20110821144352.GJ2203@ZenIV.linux.org.uk>
	<20110821164124.GL2203@ZenIV.linux.org.uk>
	<CAObL_7E1vU8+0UQST6Smf9j40TckTzB=QdY0AuAWo4AX6cs2xg@mail.gmail.com>
	<20110822011645.GM2203@ZenIV.linux.org.uk>
	<CA+55aFz1jCZGcQ-c6uGN=k8nKDuGoz5g8e+pxpYAg4X_p7=5Mw@mail.gmail.com>
	<4E51B56F.3080301@zytor.com>
	<CAObL_7HLDD=FVSN58W7a0g0R--8x7OVrQVCBxWD1DirVZxRn2w@mail.gmail.com>
	<20110822020737.GP2203@ZenIV.linux.org.uk>
	<CAObL_7HY7qFUoqtNju42=BHTR8WuuW-cL_cQh_uUfx_7gFfHRg@mail.gmail.com>
	<4E51D597.3060800@zytor.com> <20110822095336.GB25949@kernel.org>
From: Andrew Lutomirski <luto@mit.edu>
Date: Mon, 22 Aug 2011 09:34:27 -0400
Message-ID: <CAObL_7F6D8nQovf+aJGiEOF1mBpBU8RwtjNA-5myxvEBRRHgsg@mail.gmail.com>
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
To: Ingo Molnar <mingo@kernel.org>
Cc: user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, Borislav Petkov <bp@amd64.org>, mingo@redhat.com, Al Viro <viro@zeniv.linux.org.uk>, "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Mon, Aug 22, 2011 at 5:53 AM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * H. Peter Anvin <hpa@zytor.com> wrote:
>
>> Borislav,
>>
>> We're tracking down an issue with the way system call arguments are
>> handled on 32 bits. =A0We have a solution for SYSENTER but not
>> SYSCALL; fixing SYSCALL "properly" appears to be very difficult at
>> best.
>>
>> So the question is: how much overhead would it be to simply fall
>> back to int $0x80 or some other legacy-style domain crossing
>> instruction for 32-bit system calls on AMD64 processors? =A0We don't
>> ever use SYSCALL in legacy mode, so native i386 kernels are
>> unaffected.
>
> Last i measured INT80 and SYSCALL costs they were pretty close to
> each other on AMD CPUs - closer than on Intel.

>>From memory, SYSCALL in 64-bit mode on Sandy Bridge is much faster
than int 0xcc, which is presumably about the same speed as int 0x80.
That's because SYSCALL is blazingly fast (<30 ns for a whole system
call) and int is slower.

--Andy

>
> Also, most installations are either pure 32-bit or dominantly 64-bit,
> the significantly mixed-mode case is dwindling.
>
> Unifying some more in this area would definitely simplify things ...
>
> Thanks,
>
> =A0 =A0 =A0 =A0Ingo
>

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

