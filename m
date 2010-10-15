Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <richard.weinberger@gmail.com>) id 1P6gWN-0005rq-Uo
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 15 Oct 2010 09:24:15 +0000
Received: from mail-qy0-f182.google.com ([209.85.216.182])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P6gWN-0001Gf-2O for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 15 Oct 2010 09:24:15 +0000
Received: by qyk30 with SMTP id 30so703865qyk.13
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 15 Oct 2010 02:24:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1287128928.29097.1235.camel@twins>
References: <AANLkTinNxzktyttzEjWSUPBiOUwh+4DUL0tmP7p1UiT5@mail.gmail.com>
	<4CB75F05.9070505@linux.intel.com>
	<AANLkTik5_TCXeGzTWBZzE8F0Cb2bQq-D228xDXk87rhP@mail.gmail.com>
	<AANLkTi=vYFv+S=D6O06Nys4cjU7KHWv11d_VdLGmLyf6@mail.gmail.com>
	<1287128928.29097.1235.camel@twins>
Date: Fri, 15 Oct 2010 11:24:09 +0200
Message-ID: <AANLkTikmfpbTXz3-H_UQUqvSULifPyyib3xwsv=RafvX@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
Subject: Re: [uml-devel] [REGRESSION] um: rcu_sched_state detected stall on
	CPU 0
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
To: Peter Zijlstra <peterz@infradead.org>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>, Pekka Enberg <penberg@kernel.org>, penberg@cs.helsinki.fi, Thomas Gleixner <tglx@linutronix.de>, Arjan van de Ven <arjan@linux.intel.com>, Ingo Molnar <mingo@elte.hu>

On Fri, Oct 15, 2010 at 9:48 AM, Peter Zijlstra <peterz@infradead.org> wrot=
e:
> On Fri, 2010-10-15 at 10:02 +0300, Pekka Enberg wrote:
>> On Fri, Oct 15, 2010 at 2:44 AM, richard -rw- weinberger
>> <richard.weinberger@gmail.com> wrote:
>> > On Thu, Oct 14, 2010 at 9:50 PM, Arjan van de Ven
>> <arjan@linux.intel.com> wrote:
>> >> =A0On 10/14/2010 11:27 AM, richard -rw- weinberger wrote:
>> >>>
>> >>> Hi Arjan!
>> >>>
>> >>> This commit causes some problems on UML.
>> >>>
>> >> that is extremely weird.
>> >>>
>> >>> The kernel freezes after a few seconds until it gets some input.
>> >>> e.g: When I run top it stops refreshing the process list until i
>> press a
>> >>> button.
>> >>
>> >> a slab timer change (to not be as critical) causing global timer
>> issues....
>> >> that's very obviously not a problem with this patch.
>> >> has this been seem anywhere except UML ?
>> >
>> > A small update:
>> > It seems that CONFIG_NO_HZ is broken on UML. :-(
>> >
>> > CONFIG_NO_HZ + CONFIG_SLAB: works
>> > CONFIG_NO_HZ + CONFIG_SLAB + your patch: broken
>> > CONFIG_NO_HZ + CONFIG_SLUB: broken
>> >
>> > CONFIG_SLAB + your patch: works
>> > CONFIG_SLAB: works
>> > CONFIG_SLUB: works
>>
>> Thanks for testing! Thomas, Ingo, Peter, I'm not sure who maintains
>> CONFIG_NO_HZ so I CC'd you. The problem here is that Arjan's
>> deferrable timers patch in SLAB triggered something that looks like a
>> latent bug with UML and NOHZ.
>
> Thomas does mostly, but if its UML specific, I guess its Jeff Dike
> you'll be wanting to talk to, since he's the arch maintainer.
>

Jeff is the UML maintainer only in theory.
He seems to be very busy and hasn't touched UML since 2008.
Very sad...

-- =

Thanks,
//richard

---------------------------------------------------------------------------=
---
Download new Adobe(R) Flash(R) Builder(TM) 4
The new Adobe(R) Flex(R) 4 and Flash(R) Builder(TM) 4 (formerly =

Flex(R) Builder(TM)) enable the development of rich applications that run
across multiple browsers and platforms. Download your free trials today!
http://p.sf.net/sfu/adobe-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

