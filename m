Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ErIvy-00012H-1N for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Dec 2005 09:48:26 -0800
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1ErIvw-0002yO-TB
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Dec 2005 09:48:26 -0800
From: Antoine Martin <antoine@nagafix.co.uk>
In-Reply-To: <20051227124500.CA66633495@sc8-sf-spam1.sourceforge.net>
References: <20051227124500.CA66633495@sc8-sf-spam1.sourceforge.net>
Content-Type: text/plain
Message-Id: <1135705691.3719.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: Ho ho ho.. Linux 2.6.15-rc7
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
Date: Tue, 27 Dec 2005 17:48:11 +0000
To: user-mode-linux-devel@lists.sourceforge.net
Cc: blaisorblade@yahoo.it, jdike@karaya.com, Pekka Enberg <penberg@cs.helsinki.fi>

> On 12/25/05, Linus Torvalds <torvalds@osdl.org> wrote:
> > Please do give it a try, and if you have any issues/regressions,
> send out
> > a note (even if you sent one earlier) so that we don't forget about
> it.
> 
> Hmm. Somebody broke UML compile for my config again...
Are you sure that you are using a raw 2.6.15-rc7?
AFAIK, no new UML patches made it into rc7, and mostly fixes since rc1
(as required) I think I've had a similar issue before - can't remember
(searching the archives may help), have you tried this:
find . -size 0 -exec rm {} \;
As some of the patches may leave empty files behind.

Antoine



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
