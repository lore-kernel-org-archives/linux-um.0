Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A1A05-0006Fv-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 21 Sep 2003 12:36:05 -0700
Received: from tailtiu.davidcoulson.net ([207.166.203.132] helo=mail.mx.davidcoulson.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 1A1A03-0005Ul-W0
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 21 Sep 2003 12:36:04 -0700
Message-ID: <3F6DFD84.8090309@davidcoulson.net>
From: David Coulson <david@davidcoulson.net>
MIME-Version: 1.0
Subject: Re: [uml-devel] mounting filesystems - mount crashes
References: <20030921183013.99560.qmail@web80507.mail.yahoo.com>
In-Reply-To: <20030921183013.99560.qmail@web80507.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Sun, 21 Sep 2003 15:35:32 -0400
To: Terry <td3201@yahoo.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Terry wrote:
> I created the filesystem on the host os with dd.  I
> boot up my vm with ubd3=/uml/new_fs as a kernel
> argument.  WHen inside the VM, I create an ext2
> filesystem on it.  I am then able to mount it normally
> from there.  When I add it to fstab as:
> /dev/ubd/3     /usr            ext2    defaults 1 1
> It blows chunks.  

What's the error message? What command line are you starting UML with? 
You need to give us some information to actually debug the problem.

David

-- 
David Coulson                                    email: d@vidcoulson.com
Linux Developer /                          web: http://davidcoulson.net/
Network Engineer                                   phone: (216) 533-6967



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
