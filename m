Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Daf9r-0000dS-Mv	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 24 May 2005 12:33:43 -0700
Received: from wproxy.gmail.com ([64.233.184.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Daf9q-0003oA-BH	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 24 May 2005 12:33:43 -0700
Received: by wproxy.gmail.com with SMTP id 69so313162wri
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 24 May 2005 12:33:40 -0700 (PDT)
Message-ID: <838f7c500505241233389fd6b9@mail.gmail.com>
From: ashwin tanugula <ashwin.tanugula@gmail.com>
Reply-To: ashwin tanugula <ashwin.tanugula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Subject: [uml-devel] patch warnings
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
Date: Tue, 24 May 2005 15:33:40 -0400
Content-Transfer-Encoding: 8bit
To: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

Hi!
When i tried to generate a patch, it gave me the following erros

root@slemieux:/home/ashwin # diff -Naur
/home/ashwin/uml/linux-2.6.0-test9/ linu x-2.6.0-test9/ >
umlppc-patch1-2.6.0-test9
diff: /home/ashwin/uml/linux-2.6.0-test9/include/asm/arch: No such
file or direc tory
diff: /home/ashwin/uml/linux-2.6.0-test9/include/asm-ppc/arch: Too
many levels o f symbolic links
diff: /home/ashwin/uml/linux-2.6.0-test9/include/asm-um/arch: No such
file or di rectory

can i ignore them?

Thanks,
Ashwin


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
