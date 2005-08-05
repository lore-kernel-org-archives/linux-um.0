Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E0wjJ-000156-Lu	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Aug 2005 00:34:57 -0700
Received: from motgate3.mot.com ([144.189.100.103])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E0wjG-0007uF-5k
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Aug 2005 00:34:57 -0700
Received: from az33exr04.mot.com (az33exr04.mot.com [10.64.251.234])
	by motgate3.mot.com (8.12.11/Motgate3) with ESMTP id j757lmwM021482
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 5 Aug 2005 00:47:48 -0700 (MST)
Received: from zch07exm01.corp.mot.com (zch07exm01.corp.mot.com [200.3.1.220])
	by az33exr04.mot.com (8.13.1/8.13.0) with ESMTP id j757dOWn011797
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 5 Aug 2005 02:39:25 -0500 (CDT)
Message-ID: <AD266326EC54D9118CE700110A9E2BE205EA47EA@zch07exm01.corp.mot.com>
From: Zhu Tom-a2289c <A2289c@motorola.com>
Subject: RE: [uml-devel] NPTL pthread_create() cannot work.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
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
Date: Fri, 5 Aug 2005 15:34:49 +0800
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

1. 
I still fail to use these patches on git3/4,
so, I just made my local fix on 2.6.12-rc4.
pthread_create works goods.
and then find your fix patch include it, seems my fix
is not wrong. :-)

2.
in tls.c, 
there are some code looking up the tls_arry
for (idx = GDT_ENTRY_TLS_MIN; idx < GDT_ENTRY_TLS_MAX; idx++) {
shall we use "idx <= GDT_ENTRY_TLS_MAX"?
since
#define GDT_ENTRY_TLS_MAX 	(GDT_ENTRY_TLS_MIN + GDT_ENTRY_TLS_ENTRIES - 1)

Thanks,
Tom

-----Original Message-----
From: Blaisorblade [mailto:blaisorblade@yahoo.it] 
Sent: 2005年8月4日 2:04
To: Zhu Tom-a2289c
Cc: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] NPTL pthread_create() cannot work.

On Tuesday 02 August 2005 12:05, Zhu Tom-a2289c wrote:
> Hi Blaisor,
>
> I see your new patch on
> 
>http://www.user-mode-linux.org/~blaisorblade/patches/devel-guest/uml-2.
>6.13 -rc3-git-bb-20050731-19:08/ Does this fix the problem?

> I used vinilla 2.6.13-rc3 kernel, no matter whether adding git patch, 
> I cannot apply all the patches.
Applying *all* the patches won't work, but until *TLS* it should
> Could you indicate which kernel version I should base?
Well, that should be something along -rc4-git3/4, I gave some indications on the "NEWS page".
> Thanks,
> Tom
>
>
>
> -----Original Message-----
> From: Zhu Tom-a2289c
> Sent: 2005年8月1日 9:37
> To: 'Blaisorblade'
> Cc: user-mode-linux-devel@lists.sourceforge.net
> Subject: RE: [uml-devel] NPTL pthread_create() cannot work.
>
> > Yes, I already fixed that recently - that patch is a development one 
> > and you're the first tester I heard of.
> >
> :-)
> :
> > I've succeeded in fixing even this...
>
> Can I get your fix for the further test?
>
> > Is that compiled with NPTL / TLS support? Has 2.3.2 any TLS support 
> > at all?
>
> It is said to support NPTL 0.29.
>
> Thanks,
> Tom

--
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894) http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB http://mail.yahoo.it


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
