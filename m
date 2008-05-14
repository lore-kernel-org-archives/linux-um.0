Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JwMp4-0000Pq-2b for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 May 2008 12:39:34 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JwMp1-000653-7p
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 May 2008 12:39:34 -0700
Date: Wed, 14 May 2008 15:39:12 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080514193912.GA11531@c2.user-mode-linux.org>
References: <20080502163020.GB7843@c2.user-mode-linux.org>
	<87bq3o5yeo.fsf@hades.wkstn.nix>
	<20080502195720.GB10369@c2.user-mode-linux.org>
	<87k5ic47is.fsf@hades.wkstn.nix>
	<20080503005631.GA12599@c2.user-mode-linux.org>
	<877ieb4s4n.fsf@hades.wkstn.nix>
	<20080509151604.GC10169@c2.user-mode-linux.org>
	<1210353202.31648.8.camel@localhost>
	<20080514172347.GA10283@c2.user-mode-linux.org>
	<1210789757.25724.3.camel@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1210789757.25724.3.camel@localhost>
Subject: Re: [uml-devel] actually useful backtrace from a CPU-chewing hang
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
To: vincent-perrier <vincent-perrier@club-internet.fr>
Cc: Nix <nix@esperi.org.uk>, user-mode-linux-devel@lists.sourceforge.net

I finally reproduced this using 2.6.25.1 (2.6.25-mm1 was no good) with
your config.

The patch below fixes it for me.  You'll notice a certain similarity
between this and a previous patch that you posted.  It's not clear to
me why yours didn't work.

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
