Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hpa@zytor.com>) id 1QveDG-0006Wh-2k
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Aug 2011 23:47:26 +0000
Received: from terminus.zytor.com ([198.137.202.10] helo=mail.zytor.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QveDF-0003Hu-CF
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Aug 2011 23:47:26 +0000
Message-ID: <4E52EA50.6070105@zytor.com>
Date: Mon, 22 Aug 2011 16:46:24 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
References: <20110822011645.GM2203@ZenIV.linux.org.uk>
	<CA+55aFz1jCZGcQ-c6uGN=k8nKDuGoz5g8e+pxpYAg4X_p7=5Mw@mail.gmail.com>
	<4E51B56F.3080301@zytor.com>
	<CAObL_7HLDD=FVSN58W7a0g0R--8x7OVrQVCBxWD1DirVZxRn2w@mail.gmail.com>
	<20110822020737.GP2203@ZenIV.linux.org.uk>
	<CAObL_7HY7qFUoqtNju42=BHTR8WuuW-cL_cQh_uUfx_7gFfHRg@mail.gmail.com>
	<4E51D597.3060800@zytor.com> <20110822095336.GB25949@kernel.org>
	<CAObL_7F6D8nQovf+aJGiEOF1mBpBU8RwtjNA-5myxvEBRRHgsg@mail.gmail.com>
	<20110822144051.GD2946@aftab>
	<20110822151305.GV2203@ZenIV.linux.org.uk>
	<CA+55aFwoRO9xxnTyt_gYFdTS9LsaFoCWRuyNeXY7gvrE8CdZ0A@mail.gmail.com>
	<4E52B7F8.3050002@zytor.com>
	<CAObL_7GmMXPUE0Oix1CKTYzqheyJV+ua=WEBUQk5m-LGsvqihw@mail.gmail.com>
	<4E52D280.3010107@zytor.com>
	<CA+55aFw4C+ShLHF2NYZMQ-Lhjow3mJ62_eqO_iAww2nh7V_-Uw@mail.gmail.com>
In-Reply-To: <CA+55aFw4C+ShLHF2NYZMQ-Lhjow3mJ62_eqO_iAww2nh7V_-Uw@mail.gmail.com>
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] SYSCALL,
 ptrace and syscall restart breakages (Re: [RFC] weird crap with
 vdso on uml/i386)
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Lutomirski <luto@mit.edu>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, Richard Weinberger <richard@nod.at>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@amd64.org>, "mingo@redhat.com" <mingo@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, Ingo Molnar <mingo@kernel.org>

On 08/22/2011 04:27 PM, Linus Torvalds wrote:
> On Mon, Aug 22, 2011 at 3:04 PM, H. Peter Anvin <hpa@zytor.com> wrote:
>>
>> However, we could just issue a SIGILL or SIGSEGV at this point; the same
>> way we would if we got an #UD or #GP fault; SIGILL/#UD would be
>> consistent with Intel CPUs here.
> 
> Considering that this is not a remotely new issue, and that it has
> been around for years without anybody even noticing, I'd really prefer
> to just fix things going forwards rather than add any code to actively
> break any possible unlucky legacy users.
> 
> So I think the "let's fix the vdso case for sysenter" + "let's remove
> the 32-bit syscall vdso" is the right solution. If somebody has
> hardcoded syscall instructions, or generates them dynamically with
> some JIT, that's their problem. We'll continue to support it as well
> as we ever have (read: "almost nobody will ever notice").
> 
> One thing we *could* do is to just say "we never restart a x86-32
> 'syscall' instruction at all", and just make such a case return EINTR.
> IOW, do something along the lines of the appended pseudo-patch.
> 
> Because returning -EINTR is always "almost correct".
> 

I have to say it worries me from a potential security hole point of
view, especially since it clearly isn't very well trod ground to begin
with.  An almost-never-used path with access to the full system call
suite is scarier than hell in that sense.

Keep in mind support for SYSCALL32 is already (vendor-)conditional.

(The obvious solution of just putting the proper register frame back in
its place would be okay except for totally breaking anything
trace-on-exit as already hashed to death...)

	-hpa

------------------------------------------------------------------------------
uberSVN's rich system and user administration capabilities and model 
configuration take the hassle out of deploying and managing Subversion and 
the tools developers use with it. Learn more about uberSVN and get a free 
download at:  http://p.sf.net/sfu/wandisco-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

