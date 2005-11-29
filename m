Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eh8kS-0005yh-QX for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Nov 2005 08:54:32 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Eh8kJ-0000gH-Oo
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Nov 2005 08:54:30 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH] uml: move TMP default from /tmp to /dev/shm.
References: <200511281029.58116.rob@landley.net>
	<Pine.LNX.4.61.0511282025560.2231@filer.marasystems.com>
	<200511281547.41319.rob@landley.net>
In-Reply-To: <200511281547.41319.rob@landley.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200511291754.04540.blaisorblade@yahoo.it>
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
Date: Tue, 29 Nov 2005 17:54:04 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Rob Landley <rob@landley.net>, Henrik Nordstrom <uml@hno.marasystems.com>, Jeff Dike <jdike@addtoit.com>

On Monday 28 November 2005 22:47, Rob Landley wrote:
> On Monday 28 November 2005 13:27, Henrik Nordstrom wrote:
> > On Mon, 28 Nov 2005, Jeff Dike wrote:
> > > On Mon, Nov 28, 2005 at 11:52:15AM -0600, Rob Landley wrote:

> Inline is linux-kernel policy, but here the darn thing is as an attachment.

They explicitly accept plain-text attachments when inline doesn't work. 
However, here we are *much* liberal, since we apply anyhow patches by hand, 
and plain-text attachment works as well when feeding the patch to patch on  
stdin, even if you feed it the whole mail. IIRC.

> (No, I seem to have no control whatsoever over the type of the attachment. 

> I have checkboxes for "compress, encrypt, and sign" though, in case I can't
> figure out how to do that to the actual file...)

Don't look at the mime type...

Right-click -> "properties" -> "encoding" (I guess) -> choose "7bit" or "8bit" 
over "base64". Btw, kmail never tried to send a patch as base64, it always 
chose 7bit, as in your patch.

> I need to find a real mail client, it seems.

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
