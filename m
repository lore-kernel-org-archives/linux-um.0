Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EBt58-0006Ct-GA	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 04 Sep 2005 04:54:42 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EBt55-0008A2-Me
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 04 Sep 2005 04:54:42 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] stack and scheduler patches
References: <431637F9.6030101@oracle.com>
	<20050902165935.GA6651@ccure.user-mode-linux.org>
In-Reply-To: <20050902165935.GA6651@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509041351.32837.blaisorblade@yahoo.it>
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
Date: Sun, 4 Sep 2005 13:51:32 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Allan Graves <allan.graves@oracle.com>

On Friday 02 September 2005 18:59, Jeff Dike wrote:
> On Wed, Aug 31, 2005 at 07:06:33PM -0400, Allan Graves wrote:
> > Jeff,
> > Here's the patches.  Hope these meet your approval!
Could you please write a proper changelog? Reading a patch is possible, but 
needs time which I don't have in the very moment.

Also, what is the difference between your "stack trace" patch, which adds a 
member to thread_struct, for each process, so I'd like a minimum of 
justification, and one of the sysrq options which does exactly this?

Apart that the second is currently buggy, and is global, as in what you plan 
here:

/* Would be nice:
+           1) Send showregs output to mconsole.
+           2) Add a way to stack dump all pids.
+        */

Sorry if these questions seem bad - but that's why changelogs are used.
> > Allan

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
