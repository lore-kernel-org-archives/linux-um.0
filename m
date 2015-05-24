Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hwhilse@gmail.com>) id 1Ywf4w-0001Fh-Sx
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 24 May 2015 23:13:10 +0000
Received: from hilses.de ([213.133.103.163])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Ywf4t-0006nq-4m
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 24 May 2015 23:13:10 +0000
Received: from [10.0.0.1] (helo=localhost) by hilses.de with esmtpa (Exim 4.85)
	(envelope-from <hwhilse@gmail.com>) id 1YweSY-0007TA-LC
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 May 2015 00:33:30 +0200
MIME-Version: 1.0
Date: Mon, 25 May 2015 00:33:30 +0200
From: Hans-Werner Hilse <hwhilse@gmail.com>
In-Reply-To: <CAFLxGvxsYhRfV3aBgGtJmyPjUysnRNEx8TOOcigBZizzwz7+TA@mail.gmail.com>
References: <1432473834-26391-1-git-send-email-hwhilse@gmail.com>
	<CAFLxGvyOANSecAV+paVqir17VcaCvWWYXiv6VTSWUni8yeXxHg@mail.gmail.com>
	<CAFLxGvxsYhRfV3aBgGtJmyPjUysnRNEx8TOOcigBZizzwz7+TA@mail.gmail.com>
Message-ID: <5927bc1051d8a89c65d4c33931400b00@hilses.de>
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
Subject: Re: [uml-devel] [PATCH] um: handle GCC 5.x like GCC 4.x
To: user-mode-linux-devel@lists.sourceforge.net

Hi Richard,

Am 2015-05-25 00:12, schrieb Richard Weinberger:
> On Sun, May 24, 2015 at 6:12 PM, Richard Weinberger
> <richard.weinberger@gmail.com> wrote:
>> Hmm, instead of continue with that hack it would be much nicer to get 
>> rid
>> of the copy&pasted __user define.
> 
> Hans-Werner, can you please give the attached patch a try?
> It should fix your issue too.

Thanks for spending the time!

Indeed, it works (tried it against Linus' master) and fixes the issue
I encountered with GCC 5.1.0.

It looks much cleaner afterwards, too :-)

-hwh

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

