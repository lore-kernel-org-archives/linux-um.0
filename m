Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E9rs5-0006fA-Mq	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Aug 2005 15:12:53 -0700
Received: from ns.theshore.net ([67.18.92.50] helo=www.theshore.net)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E9rs4-0000gD-BQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Aug 2005 15:12:53 -0700
Message-ID: <43138860.6080505@theshore.net>
From: "Christopher S. Aker" <caker@theshore.net>
MIME-Version: 1.0
Subject: Re: [uml-devel] Possible SKAS3 >= v8 bug
References: <42FB5D26.5020703@theshore.net> <42FBBDF8.2020206@theshore.net>
	<42FBF41A.5090105@theshore.net> <200508211429.56287.blaisorblade@yahoo.it>
In-Reply-To: <200508211429.56287.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Mon, 29 Aug 2005 17:12:48 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

Blaisorblade wrote:
> Ok, I'm particularly suspicious of one patch, ptrace_ldt-reload-smp-fix, try 
> unapplying that one. I don't know exactly *how* it might trigger that crash, 
> but it seems a data corruption, and that code is doing exactly that.

I recompiled 2.6.12.5 with skas-v8 minus the ptrace_ldt-reload-smp-fix 
patch, and experienced another crash.  No console output was captured by 
my remote logging or console unit.

-Chris



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
