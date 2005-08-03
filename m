Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E0NW1-0007dC-5B	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Aug 2005 10:58:53 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1E0NVy-0006pd-LR
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Aug 2005 10:58:53 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] NPTL pthread_create() cannot work.
References: <AD266326EC54D9118CE700110A9E2BE205D707D7@zch07exm01.corp.mot.com>
In-Reply-To: <AD266326EC54D9118CE700110A9E2BE205D707D7@zch07exm01.corp.mot.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508032003.48667.blaisorblade@yahoo.it>
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
Date: Wed, 3 Aug 2005 20:03:48 +0200
To: Zhu Tom-a2289c <A2289c@motorola.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tuesday 02 August 2005 12:05, Zhu Tom-a2289c wrote:
> Hi Blaisor,
>
> I see your new patch on
> http://www.user-mode-linux.org/~blaisorblade/patches/devel-guest/uml-2.6.13
>-rc3-git-bb-20050731-19:08/ Does this fix the problem?

> I used vinilla 2.6.13-rc3 kernel, no matter whether adding git patch,
> I cannot apply all the patches.
Applying *all* the patches won't work, but until *TLS* it should
> Could you indicate which kernel version I should base?
Well, that should be something along -rc4-git3/4, I gave some indications on 
the "NEWS page".
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
> > Yes, I already fixed that recently - that patch is a development one and
> > you're the first tester I heard of.
> >
> :-)
> :
> > I've succeeded in fixing even this...
>
> Can I get your fix for the further test?
>
> > Is that compiled with NPTL / TLS support? Has 2.3.2 any TLS support at
> > all?
>
> It is said to support NPTL 0.29.
>
> Thanks,
> Tom

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
