Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CwnAG-0007tS-Gx for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 Feb 2005 12:01:20 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CwnAE-0008KL-Gp for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 Feb 2005 12:01:20 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Fwd: RE: [uml-devel] UML remote GUI problems
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502032100.27959.blaisorblade@yahoo.it>
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
Date: Thu, 3 Feb 2005 21:00:27 +0100
To: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

I'm forwarding this to the list because I've not the time to look at every UML 
user issue, and especially not now. I hope someone else can help you.

----------  Forwarded Message  ----------

Subject: RE: [uml-devel] UML remote GUI problems
Date: Thursday 03 February 2005 20:24
From: Greg Furlong <C01386107@student.dit.ie>
To: Blaisorblade <blaisorblade@yahoo.it>

I have sshd running on the Linux machine and then i tried to run port
forwarding through putty on port 5900. I then ran the command export
DISPLAY=host-ip.

I then used tightVNC to connect to the ip address that i had assigned while
setting up the port forwarding.

I keep getting an error Failed to server address. Did you type the address
correctly.

Regards

>===== Original Message From Blaisorblade <blaisorblade@yahoo.it> =====
>
>On Friday 28 January 2005 17:30, Greg Furlong wrote:
>> I am a final year student taking a degree in Computing at Dublin Institute
>> of Technology - Ireland. In my final year project I am doing a project
>> using User Mode Linux. My project has set out to research the capabilities
>> of User Mode Linux in a teaching environment.
>>
>> So far I have set up a server
>> and now have users logging on from a terminal. They use a COW file so as
>> not to corrupt the file system. Next I want to investigate and test the
>> capabilities of User Mode Linux over a network using a Graphical User
>> Interface. The problem that I am having is that I am finding it difficult
>> to set up the GUI system.
>>
>> I was wondering if anybody could give me some
>> pointers in the right direction
>
>Without knowing which are your difficulties? It's difficult.
>
>> or could tell me of a tutorial on how to
>> set it up.
>>
>> I have already looked at the user mode Linux
>> website on sourceforge but have been unable to successfully complete the
>> GUI instructions.
>
>What's the problem?
>
>You must install Xnest inside your guest system... it will then be able to
>forward connection to another X system (on which you have to authorize TCP
>connections from the UML system). Then it should work, more or less.
>
>> I am running Red Hat Linux 9 2.4.20-8
>> User mode Linux Patch 2.4.27-1
>> Remote Terminal Putty
>
>On windows? well, there are also Xservers on Windows (the cygwin one for
>instance)...
>--
>Paolo Giarrusso, aka Blaisorblade
>Linux registered user n. 292729
>http://www.user-mode-linux.org/~blaisorblade
>
>--
>This message has been scanned for content and
>viruses by the DIT Information Services MailScanner
>Service, and is believed to be clean.
>http://www.dit.ie

--
This message has been scanned for content and
viruses by the DIT Information Services MailScanner
Service, and is believed to be clean.
http://www.dit.ie

-------------------------------------------------------

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
