Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EzBt2-0005iY-Bt for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 03:54:00 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EzBsz-0003UN-S6
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 03:54:00 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: [PATCH 1/9] uml: avoid sysfs warning on hot-unplug
References: <20060118011200.GA28086@kroah.com>
In-Reply-To: <20060118011200.GA28086@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601181253.54942.blaisorblade@yahoo.it>
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
Date: Wed, 18 Jan 2006 12:53:54 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Greg KH <greg@kroah.com>, akpm@osdl.org, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org

On Wednesday 18 January 2006 02:12, Greg KH wrote:
> > From: Jeff Dike <jdike@addtoit.com>, Paolo 'Blaisorblade' Giarrusso
> > <blaisorblade@yahoo.it>
> >
> > Define a release method for the ubd and network driver so that sysfs
> > doesn't complain when one is removed via:

> What?  No.  The kernel is complaining for a reason, don't try to
> out-smart it.

I'm not trying to ignore the warning.

> > host $ uml_mconsole <umid> remove <dev>

> > Done by Jeff around January for ubd only, later lost, then restored in
> > his tree - however I'm merging it now since there's no reason to leave
> > this here.

> > We don't need to do any cleanup in the new added method, because when
> > hot-unplug is done by uml_mconsole we already handle cleanup in mconsole
> > infrastructure, i.e.  mc_device->remove (net_remove/ubd_remove), which is
> > also the calling method.

> Huh?  You have 2 different release functions for the same object?

Not sure which ones you refer. net_remove and ubd_remove are for different 
devices; mc_device->remove and the sysfs release are in different layers and 
for different things.

> And 
> how do you know which one is correct?  That does not sound right at all.

No, but since we don't have plugs, we get configuration requests to remove 
devices.

And currently, since this existed in already 2.4, the handler of the 
configuration request(mc_device->remove) does all the work to shutdown the 
interface, and then calls into the kobject stuff (with 
platform_device_unregister()); and this complains for the missing ->remove.

If it's better, we may try to move things inside the sysfs ->remove event, 
with care because different stuff has been done.

However, there are a lot of things to look at here... is there anything in 
ubd_remove() smelling awful? Because we have a crash which is caused by us 
harming sysfs data structures, which triggers on ubd_remove().

Bug report:
http://marc.theaimsgroup.com/?l=user-mode-linux-devel&m=113537479514679&w=2

investigations:
http://marc.theaimsgroup.com/?l=user-mode-linux-devel&m=113538805406552&w=2

> Please fix this correctly.

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
