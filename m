Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C1lzZ-0006Lx-6E for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Aug 2004 06:14:37 -0700
Received: from web12502.mail.yahoo.com ([216.136.173.194])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1C1lzY-00063l-Gw for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Aug 2004 06:14:36 -0700
Message-ID: <20040830131435.28489.qmail@web12502.mail.yahoo.com>
From: Sam T Sander <ssander@rocketmail.com>
Subject: Re: [uml-devel] fixing ptrace for ARM
In-Reply-To: <200408292341.10362.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-210482038-1093871675=:27540"
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
Date: Mon, 30 Aug 2004 06:14:35 -0700 (PDT)
To: BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net
Cc: Sam T Sander <ssander@rocketmail.com>

--0-210482038-1093871675=:27540
Content-Type: text/plain; charset=us-ascii

Thanks for the tip BlaisorBlade!  Something about sysemu should be added to the porting page.
 
-Sam

BlaisorBlade <blaisorblade_spam@yahoo.it> wrote:
I think that the work must be done in the stack layout on ptracing (read the 
handle_trap() function for what UML does). But also see this URL: 

http://perso.wanadoo.fr/laurent.vivier/UML/

One of the nice thing of those patches is that if you implement something 
similar (which is a lot easier IMHO) you don't need to be able to change 
system call numbers.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

		
---------------------------------
Do you Yahoo!?
Win 1 of 4,000 free domain names from Yahoo! Enter now.
--0-210482038-1093871675=:27540
Content-Type: text/html; charset=us-ascii

<DIV>Thanks for the tip BlaisorBlade!&nbsp; Something about sysemu should be added to the porting page.</DIV>
<DIV>&nbsp;</DIV>
<DIV>-Sam<BR><BR><B><I>BlaisorBlade &lt;blaisorblade_spam@yahoo.it&gt;</I></B> wrote:</DIV>
<BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">I think that the work must be done in the stack layout on ptracing (read the <BR>handle_trap() function for what UML does). But also see this URL: <BR><BR>http://perso.wanadoo.fr/laurent.vivier/UML/<BR><BR>One of the nice thing of those patches is that if you implement something <BR>similar (which is a lot easier IMHO) you don't need to be able to change <BR>system call numbers.<BR>-- <BR>Paolo Giarrusso, aka Blaisorblade<BR>Linux registered user n. 292729<BR></BLOCKQUOTE><p>
		<hr size=1>Do you Yahoo!?<br>
Win 1 of 4,000 free domain names from Yahoo! <a
href="http://us.rd.yahoo.com/evt=26640/*http://promotions.yahoo.com/goldrush">Enter now</a>.
--0-210482038-1093871675=:27540--


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
