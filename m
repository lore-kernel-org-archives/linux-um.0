Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19zKB2-0004b6-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 16 Sep 2003 11:03:48 -0700
Received: from smtp013.mail.yahoo.com ([216.136.173.57])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 19zKB1-0007dU-S7
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 16 Sep 2003 11:03:47 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309161559.18993.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Little heap overflow in mconsole_kern.c
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
Date: Tue, 16 Sep 2003 15:59:18 +0200
To: user-mode-linux-devel@lists.sourceforge.net

In that file(releases 2.4.22-3um and -4um at least), we have this code:
[...]

void mconsole_interrupt(int irq, void *dev_id, struct pt_regs *regs)
{
	int fd;
	struct mconsole_entry *new;
	struct mc_request req;

[...]
			new = kmalloc(sizeof(req), GFP_ATOMIC);
			if(new == NULL)
				mconsole_reply(&req, "Out of memory", 1, 0);
			else {
				new->request = req;
				list_add(&new->list, &mc_requests);
			}
[...]
While new points to a mconsole_entry, the code allocates sizeof(mc_request), 
not sizeof(mconsole_entry), which is less than needed. I've looked for any 
reasons for this to be correct(even in the weird Linux list implementation), 
but seems just a typo(not noticed since the actual overflow is unlikely to 
happen, but it's there). Could you change it?(I didn't post a patch because 
it's simpler to edit the code at hand).
-- 
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
