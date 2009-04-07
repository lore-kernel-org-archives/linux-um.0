Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <inguin@gmx.de>) id 1LrIlW-0003AJ-Qr
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Apr 2009 21:23:30 +0000
Received: from mail.gmx.net ([213.165.64.20])
	by 3b2kzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1LrIlV-0002Qc-TO for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Apr 2009 21:23:30 +0000
Message-ID: <49DBC44A.5070700@gmx.de>
Date: Tue, 07 Apr 2009 23:23:22 +0200
From: Ingo van Lil <inguin@gmx.de>
MIME-Version: 1.0
References: <49DB91C6.7030005@gmx.de> <49DB9B13.80203@meduna.org>
In-Reply-To: <49DB9B13.80203@meduna.org>
Subject: Re: [uml-devel] Multi-threaded applications and floating point
	registers
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
To: Stanislav Meduna <stano@meduna.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

Stanislav Meduna wrote:

>> I'm experiencing some weird problems with a multi-threaded application 
>> I'm working on: A function which uses nothing but a single input value, 
>> a few constants and a couple of floating point operations returns wrong 
>> results from time to time. The application uses multiple threads, and 
>> we're suspecting that the FPU state isn't properly saved and restored 
>> when switching between threads within a process.
> 
> I had a similar problem between processes a few months ago,
> I also posted an example, unfortunately with no resolution
> nor further inquiries from the developers. I suspect the skas3
> patch does not get much attention now...

Yes, I remember the thread. I don't think we're hitting the same
problem, though: I'm not using the SKAS3 patch, and I did not notice any
kind of cross-process influence. The effect is limited to threads
sharing a single process context.

Regards,
Ingo

------------------------------------------------------------------------------
This SF.net email is sponsored by:
High Quality Requirements in a Collaborative Environment.
Download a free trial of Rational Requirements Composer Now!
http://p.sf.net/sfu/www-ibm-com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

