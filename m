Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JPmNy-0006AT-Tm for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Feb 2008 14:16:54 -0800
Received: from w12a.httpserveur.net ([67.15.80.77]
	helo=websiteout12.httpserveur.net)
	by mail.sourceforge.net with smtp (Exim 4.44) id 1JPmNx-0005EB-I9
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Feb 2008 14:16:54 -0800
Message-ID: <47B4BDCD.4080605@club-internet.fr>
Date: Thu, 14 Feb 2008 23:16:45 +0100
From: clowncoder <vincent-perrier@club-internet.fr>
MIME-Version: 1.0
References: <47B34BA0.30006@club-internet.fr>
	<20080214003853.GA15952@c2.user-mode-linux.org>
In-Reply-To: <20080214003853.GA15952@c2.user-mode-linux.org>
Subject: Re: [uml-devel] g_timeout_add
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

With strace, when I do nothing on the gtk screen, we get
what is under, it seems that the poll has a 5000 milli-sec
timeout, but takes 10 sec to wake.

When I move the mouse on the gtk screen, there are too many
events on the screen to see anything but I can send it if you
need it.

gettimeofday({1203026980, 431960}, NULL) = 0
poll([{fd=3, events=POLLIN}], 1, 5000)  = 0
gettimeofday({1203026990, 459054}, NULL) = 0
gettimeofday({1203026990, 459250}, NULL) = 0
write(1, "1203026990\n", 111203026990
)            = 11
read(3, 0x809e004, 4096)                = -1 EAGAIN (Resource 
temporarily unavailable)
gettimeofday({1203026990, 459871}, NULL) = 0
poll([{fd=3, events=POLLIN}], 1, 5000)  = 0
gettimeofday({1203027000, 470939}, NULL) = 0
gettimeofday({1203027000, 471136}, NULL) = 0
write(1, "1203027000\n", 111203027000
)            = 11


Jeff Dike wrote:
> On Wed, Feb 13, 2008 at 08:57:20PM +0100, clowncoder wrote:
>   
>> It seems that g_timeout_add glib timeouts are not accurate
>> when there is no gtk activity on an uml target.
>>
>> This may be a glib problem since I cannot check
>> that it does not occur on my host.
>>
>> When gtk events occur through mouse moves, then
>> the timeout is good (a 5 sec timeout) if no graphical
>> activity exists, the timeout takes an average of 12 sec,
>> even if there is console activity on the uml machine.
>>     
>
> You're going to need to tell me what's happening at the system call
> level - i.e. strace it and see what is doing something it shouldn't.
>
> 				Jeff
>
>   


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
