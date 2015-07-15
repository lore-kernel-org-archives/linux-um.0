Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1ZFJfz-000105-HH
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 15 Jul 2015 10:12:31 +0000
Received: from mail-oi0-f50.google.com ([209.85.218.50])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZFJfx-0005I7-R6
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 15 Jul 2015 10:12:31 +0000
Received: by oibn4 with SMTP id n4so25072801oib.3
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 15 Jul 2015 03:12:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1436800335.3096.2.camel@m3y3r.de>
References: <1436794918.3306.5.camel@m3y3r.de>
	<CAFLxGvwo2hjvrkF_ChR1Ooc6o7OqEGEOKnP=4NAmt8vP07Kd-Q@mail.gmail.com>
	<1436795884.3306.7.camel@m3y3r.de> <55A3C47B.8040206@nod.at>
	<1436797445.3306.10.camel@m3y3r.de> <55A3CE2F.5030105@nod.at>
	<1436800131.3096.1.camel@m3y3r.de> <55A3D510.7000508@nod.at>
	<1436800335.3096.2.camel@m3y3r.de>
Date: Wed, 15 Jul 2015 12:12:24 +0200
Message-ID: <CAFLxGvwtR+obJ97Zjh81JMjMgsY4+hhX4qupbhOem7CaGpjGSQ@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
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
Subject: Re: [uml-devel] uml_net zombie processes
To: Thomas Meyer <thomas@m3y3r.de>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Mon, Jul 13, 2015 at 5:12 PM, Thomas Meyer <thomas@m3y3r.de> wrote:
> Am Montag, den 13.07.2015, 17:11 +0200 schrieb Richard Weinberger:
>> Am 13.07.2015 um 17:08 schrieb Thomas Meyer:
>> > Am Montag, den 13.07.2015, 16:41 +0200 schrieb Richard Weinberger:
>> > > Am 13.07.2015 um 16:24 schrieb Thomas Meyer:
>> > > > > Yeah. And please add a dump_stack() to figure out where it
>> > > > > was
>> > > > > called.
>> > > >
>> > > > I think calling dump_stack() somehow changed the errno to 25?!
>> > >
>> > > >
>> > > > +extern __attribute__((regparm(0))) void dump_stack(void);
>> > >
>> > > Hmm, maybe the regparm(0) kills your stack.
>> > > Anyway, how do you trigger the issue?
>> > > I tried here and don't see any zombie processes?
>> > > In my setup I run UML as non-root and tap0 is owned by root.
>> > > -> UML is unable to setup eth0.
>> > > But no zombies here.
>> >
>> > I run UML as non-root user, tun is:
>> >
>> > $ ll /dev/net
>> > insgesamt 0
>> > crw-rw----. 1 root zml-net 10, 200 13. Jul 14:49 tun
>> >
>> > $ ll /usr/bin/uml_net
>> > -rwsr-x---. 1 root uml-net 31472 19. Aug 2014  /usr/bin/uml_net
>>
>> And eth0=tuntap,tap?
>
> yes,
>
> eth0=tuntap,,,192.168.10.2

Sorry for the late reply.
I'm still burred in work issues and had no time to look in detail at this.

But in the meanwhile you can try to gather some more Infos.
Remove the dump_stack() and add some printk()s.
I'm interested which PIDs are returned and waited for.

-- 
Thanks,
//richard

------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

