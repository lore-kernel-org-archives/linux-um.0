Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19umPL-0001Mb-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Wed, 03 Sep 2003 22:11:47 -0700
Received: from bay7-f82.bay7.hotmail.com ([64.4.11.82] helo=hotmail.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19umPL-0004s2-D7
	for User-mode-linux-devel@lists.sourceforge.net; Wed, 03 Sep 2003 22:11:47 -0700
From: "Steve Schmidtke" <steve_schmidtke@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY7-F82eujjeHdzXT60000f1c9@hotmail.com>
Subject: [uml-devel] cleanup file io
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
Date: Thu, 04 Sep 2003 05:11:11 +0000
To: jdike@addtoit.com
Cc: User-mode-linux-devel@lists.sourceforge.net

Hi Jeff,

Can I submit a cleanup patch that does stuff like this all over UML:

int load_initrd(char *filename, void *buf, int size)
{
        int fd, n;

        if((fd = os_open_file(filename, of_read(OPENFLAGS()), 0)) < 0){
-               printk("Opening '%s' failed - errno = %d\n", filename, 
errno);
+               printk("Opening '%s' failed - err = %d\n", filename, fd);
                return(-1);
        }
-       if((n = read(fd, buf, size)) != size){
+       if((n = os_read_file(fd, buf, size)) != size){
                printk("Read of %d bytes from '%s' returned %d, errno = 
%d\n",
                       size, filename, n, errno);
                return(-1);
        }
        return(0);
}

i.e. wrap bare file functions into their os_* counterparts, and remove 
unnecessary references to errno?

Also, is there a style reason some functions like the one above return -1 
rather than -errno or the failed (negative) return value from the os_* 
functions?  I'd like to standardize one style or the other while I'm at it, 
if that's workable.

Thanks,

Steve Schmidtke

_________________________________________________________________
Add photos to your e-mail with MSN 8. Get 2 months FREE*.  
http://join.msn.com/?page=features/featuredemail



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
