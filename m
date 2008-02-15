Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JQ4Wy-0002yu-Fa for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 15 Feb 2008 09:39:25 -0800
Received: from w12a.httpserveur.net ([67.15.80.77]
	helo=websiteout12.httpserveur.net)
	by mail.sourceforge.net with smtp (Exim 4.44) id 1JQ4Wx-00073c-3d
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 15 Feb 2008 09:39:24 -0800
Message-ID: <47B5CE40.9000005@club-internet.fr>
Date: Fri, 15 Feb 2008 18:39:12 +0100
From: clowncoder <vincent-perrier@club-internet.fr>
MIME-Version: 1.0
References: <47B34BA0.30006@club-internet.fr>
	<20080214003853.GA15952@c2.user-mode-linux.org>
	<47B4BDCD.4080605@club-internet.fr>
	<20080215160205.GA6082@c2.user-mode-linux.org>
In-Reply-To: <20080215160205.GA6082@c2.user-mode-linux.org>
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


Here it is:

By the way, do you use other very interresting tools such as strace?
if so could you give me names?



1203096910.892244 poll([{fd=3, events=POLLIN}, {fd=4, events=POLLIN}], 
2, 4994) = 0
1203096922.904300 gettimeofday({1203096922, 904988}, NULL) = 0
1203096922.905867 gettimeofday({1203096922, 906552}, NULL) = 0
1203096922.907449 write(1, "1203096922\n", 111203096922
) = 11
1203096922.909681 read(3, 0x809e004, 4096) = -1 EAGAIN (Resource 
temporarily unavailable)
1203096922.911270 gettimeofday({1203096922, 911946}, NULL) = 0
1203096922.912827 poll([{fd=3, events=POLLIN}, {fd=4, events=POLLIN}], 
2, 4994) = 0
1203096934.924538 gettimeofday({1203096934, 924926}, NULL) = 0
1203096934.925477 gettimeofday({1203096934, 925851}, NULL) = 0
1203096934.926400 write(1, "1203096934\n", 111203096934
) = 11
1203096934.927673 read(3, 0x809e004, 4096) = -1 EAGAIN (Resource 
temporarily unavailable)
1203096934.928613 gettimeofday({1203096934, 928937}, NULL) = 0
1203096934.929524 poll([{fd=3, events=POLLIN}, {fd=4, events=POLLIN}], 
2, 4996) = 0
1203096946.929030 gettimeofday({1203096946, 929420}, NULL) = 0
1203096946.929968 gettimeofday({1203096946, 930339}, NULL) = 0
1203096946.930882 write(1, "1203096946\n", 111203096946
) = 11
1203096946.932147 read(3, 0x809e004, 4096) = -1 EAGAIN (Resource 
temporarily unavailable)
1203096946.933062 gettimeofday({1203096946, 933422}, NULL) = 0
1203096946.933947 poll([{fd=3, events=POLLIN}, {fd=4, events=POLLIN}], 
2, 4996) = 0
1203096958.157856 gettimeofday({1203096958, 158538}, NULL) = 0
1203096958.159413 gettimeofday({1203096958, 160094}, NULL) = 0
1203096958.160992 write(1, "1203096958\n", 111203096958
) = 11


Jeff Dike wrote:
> On Thu, Feb 14, 2008 at 11:16:45PM +0100, clowncoder wrote:
>   
>> With strace, when I do nothing on the gtk screen, we get
>> what is under, it seems that the poll has a 5000 milli-sec
>> timeout, but takes 10 sec to wake.
>>     
>
> Can you show that with timestamps (strace -ttt)?
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
