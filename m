Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hpa@zytor.com>) id 1QwKiW-0007oX-4x
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Aug 2011 21:10:32 +0000
Received: from terminus.zytor.com ([198.137.202.10] helo=mail.zytor.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QwKiT-0000wP-T2
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Aug 2011 21:10:32 +0000
Message-ID: <4E5568AC.2040605@zytor.com>
Date: Wed, 24 Aug 2011 14:10:04 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
References: <20110823010146.GY2203@ZenIV.linux.org.uk>
	<20110823011312.GZ2203@ZenIV.linux.org.uk>
	<20110823021717.GA2203@ZenIV.linux.org.uk>
	<20110823061531.GC2203@ZenIV.linux.org.uk>
	<CA+55aFzUAuPEwcvVvuXooWMT6XpDuOjEHi-Ab+SOhZVjfbVYpA@mail.gmail.com>
	<CAObL_7F-E2y_cd1MK4ayBx_CqszrewSrBt6V7=ndVuBQrrmTKQ@mail.gmail.com>
	<20110823162251.GC13138@aftab> <4E53FC6E.1030807@zytor.com>
	<20110823205616.GA15295@aftab> <4E54163B.6080205@zytor.com>
	<20110823211047.GC15295@aftab>
In-Reply-To: <20110823211047.GC15295@aftab>
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
To: Borislav Petkov <bp@amd64.org>
Cc: Andrew Lutomirski <luto@mit.edu>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, Richard Weinberger <richard@nod.at>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, Ingo Molnar <mingo@kernel.org>

On 08/23/2011 02:10 PM, Borislav Petkov wrote:
> On Tue, Aug 23, 2011 at 05:06:03PM -0400, H. Peter Anvin wrote:
>> On 08/23/2011 01:56 PM, Borislav Petkov wrote:
>>>
>>> But no, I don't think the difference has disappeared - to the contrary,
>>> AFAICT, the intention is for SYSCALL to be the fastest way to do
>>> syscalls on x86 due to diminished number of segment checks etc. INT80
>>> is legacy, slower, etc. I believe Andy measured a similar situation on
>>> Sandy Bridge with SYSCALL having latencies in the tens of nsecs range
>>> and INT80 being much slower. Ingo also measured a similar situation
>>> where the latency gap between the two on Intel is even bigger.
>>>
>>
>> Sandy Bridge doesn't have SYSCALL32 at all.  It has SYSENTER and SYSCALL64.
> 
> Yeah, I was talking about SYSCALL in general.
> 

By the way, Borislav;

any way you could nudge your hardware people into

a) supporting SYSENTER in compatibility mode, and
b) giving us a way to turn SYSCALL *off* in compat mode?

... for future chips?

	-hpa

------------------------------------------------------------------------------
EMC VNX: the world's simplest storage, starting under $10K
The only unified storage solution that offers unified management 
Up to 160% more powerful than alternatives and 25% more efficient. 
Guaranteed. http://p.sf.net/sfu/emc-vnx-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

