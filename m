Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AAYIg-0005NV-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Fri, 17 Oct 2003 10:22:07 -0700
Received: from brown.brainfood.com ([146.82.138.61] helo=gradall.private.brainfood.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1AAYGc-0001lZ-Mo
	for User-mode-linux-devel@lists.sourceforge.net; Fri, 17 Oct 2003 10:19:58 -0700
From: Adam Heath <adam@doogie.org>
Subject: Re: [uml-devel] filemap feature 2.4.22-5um
In-Reply-To: <BAY7-F67zjLYL23VZvZ0000e11f@hotmail.com>
Message-ID: <Pine.LNX.4.44.0310171213360.1367-100000@gradall.private.brainfood.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Fri, 17 Oct 2003 12:14:03 -0500 (CDT)
To: Steve Schmidtke <steve_schmidtke@hotmail.com>
Cc: User-mode-linux-devel@lists.sourceforge.net

On Tue, 14 Oct 2003, Steve Schmidtke wrote:

>   umlwrap -bind=15,/dev/shm/mconsole-$$ -connect=17,/tmp/uml.ctl \
>   -dir=/home/uml -user=guest -- /bin/linux mem=64M \
>   uml_dir=/uml/ umid=um$$ ubd0=/disk.cow,/disk.dat \
>   eth0=daemon con=null con0=fd:0,fd:1 \
>   filemap=file,10,/proc/cpuinfo 10</proc/cpuinfo \
>   filemap=file,11,/disk.dat 11</mnt/backing.dat \
>   filemap=file,12,/disk.cow 12<>/home/uml/cow-$$.cow \
>   filemap=file,15,/uml/um$$/mconsole \
>   filemap=file,16,/uml/um$$/pid 16</dev/shm/pid-$$ \
>   filemap=file,17,/tmp/uml.ctl \
>   filemap=vm,20-23 20<>/dev/shm/vm-$$.0 21<>/dev/shm/vm-$$.1 \
>   22<>/dev/shm/vm-$$.2 23<>/dev/shm/vm-$$.3 \
>
> Ugly, isn't it.  If you find a nicer way to do this let me know.  Notice how
> networking is carried out here via the daemon transport, connecting to the
> /tmp/uml.ctl socket run by uml_switch.  Your mileage may vary.

I have some unfinished code to make uml read a config file.  It fits in nicely
with the cmdline parsing.



-------------------------------------------------------
This SF.net email sponsored by: Enterprise Linux Forum Conference & Expo
The Event For Linux Datacenter Solutions & Strategies in The Enterprise 
Linux in the Boardroom; in the Front Office; & in the Server Room 
http://www.enterpriselinuxforum.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
