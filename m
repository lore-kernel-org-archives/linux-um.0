Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1YrYCf-00063a-Lr
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 10 May 2015 20:52:01 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YrYCe-00038R-9W
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 10 May 2015 20:52:01 +0000
Message-ID: <554FC4E7.6070701@nod.at>
Date: Sun, 10 May 2015 22:51:51 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <1431213268.603436.33.camel@m3y3r.de>
	<CAFLxGvzjETKQ7EMF61WCcb3RBA4QZHdxA5dcx20QHwhwp0hbAg@mail.gmail.com>
	<3985DC9F-E8A3-431E-8A7F-B867DB0B99AF@m3y3r.de>
In-Reply-To: <3985DC9F-E8A3-431E-8A7F-B867DB0B99AF@m3y3r.de>
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
To: Thomas Meyer <thomas@m3y3r.de>
Cc: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

Am 10.05.2015 um 16:34 schrieb Thomas Meyer:
> 
>> Am 10.05.2015 um 14:35 schrieb Richard Weinberger <richard.weinberger@gmail.com>:
>>
>>> On Sun, May 10, 2015 at 1:14 AM, Thomas Meyer <thomas@m3y3r.de> wrote:
>>> Hi,
>>>
>>> Changes:
>>> - also create posix timer in stub_clone_handler()
>>> - incorporated antons remarks
>>
>> Hm, this patch does a *lot* more than the changelog says.
> 
> Hi, yes PATCH was probably the wrong keyword in the subject line. It should have been RFC.
> I just wanted to have feedback of the current state of this patch/work.

Ahh, ok!

I was a bit confused as it contains beside the new features also new comments to unrelated
code, changes coding style, etc...


> I'm currently working on cleaning up the patch and switch from SIGUSR2 to SIGNALRM, which seems to be the natural thing for posix timers.
> I will send this next patch as something that should be includable into the kernel, i.e. With correct description and signed off line and so on.
> 
> But feel free to have a look at v6 and give feedback.

I will. :-)

Thanks,
//richard

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

