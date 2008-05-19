Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jy82X-0006Dq-La for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 May 2008 09:16:51 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Jy82V-0007rJ-Ka
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 May 2008 09:16:45 -0700
Date: Mon, 19 May 2008 12:16:13 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080519161613.GC17500@c2.user-mode-linux.org>
References: <4821B5FC.40307@vulnscan.org>
	<20080509154552.GH10169@c2.user-mode-linux.org>
	<48255FC4.4040805@vulnscan.org> <482AA5AE.3000900@saunalahti.fi>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <482AA5AE.3000900@saunalahti.fi>
Subject: Re: [uml-devel] umls unresponsive & consuming 100% cpu time
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
To: Sakari Ailus <sakari.ailus@saunalahti.fi>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, May 14, 2008 at 11:41:18AM +0300, Sakari Ailus wrote:
> I have three UML instances running on a host. First, they all were 
> unresponsive simultaneously using all CPU time they could get. After a 
> while they became responsive again. I could log in through SSH. The 
> funny thing is that the date command showed correct date and time (as 
> far as I remember, can't test it now as they are hung again) while the 
> time in bash prompt was constant showing the time around the initial 
> hang, which is the same on all three instances.

I reproduced and debugged a similar problem, resulting in the patch
below.  See if it makes any difference for you...

	       	  	Jeff

-- 
Work email - jdike at linux dot intel dot com

Index: 2.6/stable/arch/um/os-Linux/time.c
===================================================================
--- 2.6.orig/stable/arch/um/os-Linux/time.c	2008-05-14 14:55:56.000000000 -0400
+++ 2.6/stable/arch/um/os-Linux/time.c	2008-05-14 15:30:48.000000000 -0400
@@ -66,12 +66,21 @@ long long disable_timer(void)
 	return timeval_to_ns(&time.it_value);
 }
 
+static long long last_time;
+
 long long os_nsecs(void)
 {
 	struct timeval tv;
+	long long ret;
 
 	gettimeofday(&tv, NULL);
-	return timeval_to_ns(&tv);
+	ret = timeval_to_ns(&tv);
+
+	if((last_time != 0) && (last_time > ret))
+		ret = last_time;
+
+	last_time = ret;
+	return ret;
 }
 
 #ifdef UML_CONFIG_NO_HZ

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
