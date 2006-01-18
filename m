Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EzGij-000627-E5 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 09:03:41 -0800
Received: from mail.kroah.org ([69.55.234.183] helo=perch.kroah.org)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EzGih-00012Z-7f
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 09:03:41 -0800
From: Greg KH <greg@kroah.com>
Subject: Re: [uml-devel] Re: [PATCH 1/9] uml: avoid sysfs warning on hot-unplug
Message-ID: <20060118170212.GB12757@kroah.com>
References: <20060118011200.GA28086@kroah.com>
	<200601181253.54942.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601181253.54942.blaisorblade@yahoo.it>
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
Date: Wed, 18 Jan 2006 09:02:12 -0800
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, akpm@osdl.org, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 12:53:54PM +0100, Blaisorblade wrote:
> On Wednesday 18 January 2006 02:12, Greg KH wrote:
> > > From: Jeff Dike <jdike@addtoit.com>, Paolo 'Blaisorblade' Giarrusso
> > > <blaisorblade@yahoo.it>
> > >
> > > Define a release method for the ubd and network driver so that sysfs
> > > doesn't complain when one is removed via:
> 
> > What?  No.  The kernel is complaining for a reason, don't try to
> > out-smart it.
> 
> I'm not trying to ignore the warning.

By providing a release function that does nothing, all you are doing is
shutting the kernel up.  You are not doing anything to "fix" the real
problem at all.

> > > host $ uml_mconsole <umid> remove <dev>
> 
> > > Done by Jeff around January for ubd only, later lost, then restored in
> > > his tree - however I'm merging it now since there's no reason to leave
> > > this here.
> 
> > > We don't need to do any cleanup in the new added method, because when
> > > hot-unplug is done by uml_mconsole we already handle cleanup in mconsole
> > > infrastructure, i.e.  mc_device->remove (net_remove/ubd_remove), which is
> > > also the calling method.
> 
> > Huh?  You have 2 different release functions for the same object?
> 
> Not sure which ones you refer. net_remove and ubd_remove are for different 
> devices; mc_device->remove and the sysfs release are in different layers and 
> for different things.

Ok, but you are still adding 2 empty release functions.

Please do not do that, if you think you need this, your code logic is
wrong.

As for your specific bug report, sorry, I really don't know.

good luck,

greg k-h


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
