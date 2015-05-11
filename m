Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1YrrYD-0004rA-KE
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 May 2015 17:31:33 +0000
Received: from ivanoab4.miniserver.com ([78.31.104.92])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1YrrYC-0005VX-JB
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 May 2015 17:31:33 +0000
Received: from tun252.maui-covenant.sigsegv.cx ([192.168.17.6]
	helo=falkor.sigsegv.cx) by ivanoab4.miniserver.com with esmtps
	(TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128) (Exim 4.80)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1YrrY6-0008Js-55
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 May 2015 17:31:26 +0000
Received: from monstrousnightmare.kot-begemot.co.uk ([192.168.3.80])
	by falkor.sigsegv.cx with esmtp (Exim 4.80)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1YrrY5-0008Cr-Kp
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 May 2015 18:31:25 +0100
Message-ID: <5550E76D.2040107@kot-begemot.co.uk>
Date: Mon, 11 May 2015 18:31:25 +0100
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
MIME-Version: 1.0
References: <672e7d23-295e-42eb-a92a-d13faa966927@email.android.com>
	<5550E4E8.1090300@kot-begemot.co.uk>
In-Reply-To: <5550E4E8.1090300@kot-begemot.co.uk>
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

On 11/05/15 18:20, Anton Ivanov wrote:
> On 11/05/15 18:00, Thomas Meyer wrote:
>> Hi,
>>
>> maybe there is a bug in how the timers are created for all user space processes.
>> In the latest patch I use os__timer_remain for the initial interval.
>> The idea was to launch all timers at the same time. But I now think this can never work using relative times, especially when os__timer_remain returns 0, then the new timer is never launched.
> That is not a bad idea, just requires a more complex check in setting up
> interval so it is reset to default when a zero value or value > HZ is
> passed.
>
>
>> That may explain the hangs you see.
>>    You could try to replace os__timer_remain with the current HZ value in nanoseconds.
> I am going to adjust time.c instead as above.

Both approaches fail - the check (that is expected actually, I did not 
think properly here - it does not cover the stub in kernel/skas) and the 
setting of data to the correct initial values.

Also, if it was just not starting timers it would have been possible to 
beat the process with USR2 on the head until its morale improves. Well, 
"while true; do kill -USR2 PID ; done" does not change the behavior, it 
still hangs and is still possible to terminate the errant process by 
sending SIGSEGV to the UML thread which is shown as 100% CPU and in R state.

Problem is somewhere else. I am surprised it worked correctly in the 
original one as there for 100% flat CPU usage it should have converged 
to a behavior which is similar to what we have now.

A.

>
> A.
>
>> Kind regards
>> Thomad
>>
>> A
> [snip]
>
> A.
>
> ------------------------------------------------------------------------------
> One dashboard for servers and applications across Physical-Virtual-Cloud
> Widest out-of-the-box monitoring support with 50+ applications
> Performance metrics, stats and reports that give you Actionable Insights
> Deep dive visibility with transaction tracing using APM Insight.
> http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>


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

