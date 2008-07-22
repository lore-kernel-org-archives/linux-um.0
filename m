Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KLLn6-0000R3-34 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Jul 2008 10:36:48 -0700
Received: from nf-out-0910.google.com ([64.233.182.187])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KLLn4-0006L3-SQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Jul 2008 10:36:48 -0700
Received: by nf-out-0910.google.com with SMTP id g16so604269nfd.2
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 22 Jul 2008 10:36:45 -0700 (PDT)
Date: Tue, 22 Jul 2008 18:35:09 +0100
From: WANG Cong <xiyou.wangcong@gmail.com>
Message-ID: <20080722173509.GE3081@hack.voiplan.pt>
References: <20080722105812.GB5283@alice>
	<20080722115354.79ba2314@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080722115354.79ba2314@lxorguk.ukuu.org.uk>
Subject: Re: [uml-devel] [Patch] um: fix a build error
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
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Eric Sesterhenn <snakebyte@gmx.de>, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, xiyou.wangcong@gmail.com

On Tue, Jul 22, 2008 at 11:53:54AM +0100, Alan Cox wrote:
>> Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
>> 
>> --- linux-2.6/arch/um/drivers/line.c.orig	2008-07-22 12:06:17.000000000 +0200
>> +++ linux-2.6/arch/um/drivers/line.c	2008-07-22 12:06:49.000000000 +0200
>> @@ -362,10 +362,8 @@ static irqreturn_t line_write_interrupt(
>>  	if (tty == NULL)
>>  		return IRQ_NONE;
>>  
>> -	if (test_bit(TTY_DO_WRITE_WAKEUP, &tty->flags) &&
>> -	   (tty->ldisc.write_wakeup != NULL))
>> -		(tty->ldisc.write_wakeup)(tty);
>> -
>> +	if (test_bit(TTY_DO_WRITE_WAKEUP, &tty->flags))
>> +		tty_wakeup(tty);
>
>Sorry I should have been clearer - you don't want the test_bit either.
>

What about the below one?

Signed-off-by: WANG Cong <wangcong@zeuux.org>

---

diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index 5047490..d741f35 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -362,19 +362,7 @@ static irqreturn_t line_write_interrupt(int irq, void *data)
 	if (tty == NULL)
 		return IRQ_NONE;
 
-	if (test_bit(TTY_DO_WRITE_WAKEUP, &tty->flags) &&
-	   (tty->ldisc.write_wakeup != NULL))
-		(tty->ldisc.write_wakeup)(tty);
-
-	/*
-	 * BLOCKING mode
-	 * In blocking mode, everything sleeps on tty->write_wait.
-	 * Sleeping in the console driver would break non-blocking
-	 * writes.
-	 */
-
-	if (waitqueue_active(&tty->write_wait))
-		wake_up_interruptible(&tty->write_wait);
+	tty_wakeup(tty);
 	return IRQ_HANDLED;
 }
 

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
