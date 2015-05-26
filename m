Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stian@nixia.no>) id 1YxCzt-0003XW-Sr
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 May 2015 11:26:13 +0000
Received: from [195.159.66.51] (helo=ramslauken.nlc.no)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YxCzr-0006J9-Ql for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 May 2015 11:26:13 +0000
Received: from mail.nlc.no (ramslauken.nlc.no [195.159.66.51])
	(Authenticated sender: stian@nixia.no)
	by ramslauken.nlc.no (Postfix) with ESMTPA id 3384B1C76A9
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 26 May 2015 12:56:14 +0200 (CEST)
MIME-Version: 1.0
Date: Tue, 26 May 2015 12:56:14 +0200
From: stian@nixia.no
In-Reply-To: <5550CE0F.40504@kot-begemot.co.uk>
References: "\"<1431213268.603436.33.camel@m3y3r.de>	<CAFLxGvzjETKQ7EMF61WCcb3RBA4QZHdxA5dcx20QHwhwp0hbAg@mail.gmail.com>"
	<3985DC9F-E8A3-431E-8A7F-B867DB0B99AF@m3y3r.de>"
	<5550A5FB.4000204@brocade.com> <5550C54F.6040500@kot-begemot.co.uk>
	<5550CE0F.40504@kot-begemot.co.uk>
Message-ID: <6c5810675c786f846a68b600d63e46bb@nixia.no>
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
Subject: Re: [uml-devel] [PATCH v6] um: Add a high resolution timer subsystem
To: user-mode-linux-devel@lists.sourceforge.net

>                  nsecs = timer.it_value.tv_sec *
>                      UM_NSEC_PER_SEC +
>                      timer.it_value.tv_usec *
>                      UM_NSEC_PER_USEC;
>                  nsecs += os_nsecs();

Not looking at the rest of the code, the first thing that comes to my 
mind is that this very easy overflows if 32 bit multiplications are used 
(tv_sec is usually 32bit and dictates the first multiplication unless 
typecast is used).

Stian Skjelstad

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

