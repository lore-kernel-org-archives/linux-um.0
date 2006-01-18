Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EzIAn-0002MI-JJ for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 10:36:45 -0800
Received: from smtp008.mail.ukl.yahoo.com ([217.12.11.62])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EzIAi-0000yk-RV
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 10:36:45 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: [PATCH 1/9] uml: avoid sysfs warning on hot-unplug
References: <20060118011200.GA28086@kroah.com>
	<200601181253.54942.blaisorblade@yahoo.it>
	<20060118170212.GB12757@kroah.com>
In-Reply-To: <20060118170212.GB12757@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200601181936.26614.blaisorblade@yahoo.it>
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
Date: Wed, 18 Jan 2006 19:36:26 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Greg KH <greg@kroah.com>, akpm@osdl.org, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org

On Wednesday 18 January 2006 18:02, Greg KH wrote:
> On Wed, Jan 18, 2006 at 12:53:54PM +0100, Blaisorblade wrote:

> As for your specific bug report, sorry, I really don't know.

I know it's not something easy to find, but nor me nor Jeff master deeply the 
kobject API. And we're not short of work.

Is there anybody who while reviewing various drivers could review our ones on 
this aspect (the same way people like you use to review and fix bugs all over 
the tree)?

I know this may seem unkind, but it's a "specialization thing" - 
don't let an engineer heal somebody nor a doctor build a house, and don't 
request them doing such things - defer the thing to more competent people, if 
possible.

Alternatively, documentation is accepted. Is LDD v3 up-to-date enough? Guess 
not.

A question: looking at ide driver I saw that they don't use the 
platform_device API, because they're already in the block category.

Could we be causing trouble by using both block API (with gendisk stuff) and 
platform_device? Can platform_device

Alternatively, is drivers/input/serio/i8042.c a likely correct API example?
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger with Voice: chiama da PC a telefono a tariffe esclusive 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
