Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ADu18-0002io-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 26 Oct 2003 15:09:51 -0800
Received: from fmr01.intel.com ([192.55.52.18] helo=hermes.fm.intel.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1ADtzR-0002WE-0c
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 26 Oct 2003 15:08:05 -0800
Received: from petasus.fm.intel.com (petasus.fm.intel.com [10.1.192.37])
	by hermes.fm.intel.com (8.12.9-20030918-01/8.12.9/d: outer.mc,v 1.66 2003/05/22 21:17:36 rfjohns1 Exp $) with ESMTP id h9QN3uOc009734
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 26 Oct 2003 23:03:56 GMT
Received: from fmsmsxvs040.fm.intel.com (fmsmsxv040-1.fm.intel.com [132.233.48.108])
	by petasus.fm.intel.com (8.11.6-20030918-01/8.11.6/d: inner.mc,v 1.35 2003/05/22 21:18:01 rfjohns1 Exp $) with SMTP id h9QMxXE00564
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 26 Oct 2003 22:59:33 GMT
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [uml-devel] uml on iA-64
Message-ID: <A06801158AE07847B27A52C1A074BC1D0247BA2A@fmsmsx404.fm.intel.com>
From: "Wichmann, Mats D" <mats.d.wichmann@intel.com>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 26 Oct 2003 15:07:56 -0800
Content-Transfer-Encoding: 8bit
To: Matt Zimmerman <mdz@debian.org>, user-mode-linux-devel@lists.sourceforge.net


> > pierre.gentile@mpsa.com said:
> > > Has anyone tried to implement user-mode-linux (skas patch and um
> > > architecture) on an Itanium IA-64 machine ? 
> > 
> > Not really.  I have an IA64 box sitting next to me, and 
> > starting a port to it is on my list once I acquire some free time.
> 
> I did some preliminary investigation into making ia64 
> UML-friendly as a host (the changing syscall numbers bit), 
> and after discovering why it won't work, I sent pleas for 
> help to some HP folks to find out if it would be easy to
> fix.  I did get one interested response, but no reply to my 
> followup as yet.

It would be good if we'd be able to collect information
like this somewhere.  I know there was a porting effort
at one of the Gelato member institutions (UIUC, I think),
that released a preliminary patch earlier this year, but
it's been silent on that front since.

A collection of experiences would be a useful resource,
I'd think.



-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
