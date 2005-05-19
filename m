Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DYlFd-0005Qn-6P	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 19 May 2005 06:39:49 -0700
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DYlFb-000775-KR	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 19 May 2005 06:39:49 -0700
Message-ID: <428C971C.9030604@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] [patch 1/1] uml: replace pause with sigsuspend
References: <20050516180143.95BDB1993E0@zion.home.lan>
	<200505181718.18455.blaisorblade@yahoo.it>
	<428B9544.60902@fujitsu-siemens.com>
	<200505191535.51279.blaisorblade@yahoo.it>
In-Reply-To: <200505191535.51279.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Thu, 19 May 2005 15:39:40 +0200
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, jdike@addtoit.com

Blaisorblade wrote:
> On Wednesday 18 May 2005 21:19, Bodo Stroesser wrote:
> 
>>Maybe, we really should use sigsuspend() instead of pause(), but the
>>reason for this isn't to remove the winch_handler.
>>The current loop in winch_thread() might miss a SIGWINCH, if a SIGWINCH
>>comes in while winch_thread() isn't waiting in wait().
> 
> 
> wait()? You mean the pause()/sigsuspend() call, right? Then I probably agree.
> 
Yes. You are right. Stupid typo.

	Bodo


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
