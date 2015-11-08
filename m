Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <aivanov@Brocade.com>) id 1ZvZON-0007az-Qv
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 Nov 2015 23:28:59 +0000
Received: from mx0b-000f0801.pphosted.com ([67.231.152.113])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZvZOL-0005LE-8c
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 Nov 2015 23:28:59 +0000
Received: from pps.filterd (m0000700.ppops.net [127.0.0.1])
	by mx0b-000f0801.pphosted.com (8.15.0.59/8.15.0.59) with SMTP id
	tA8MVZLu025312 for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 8 Nov 2015 15:01:03 -0800
Received: from brmwp-exmb11.corp.brocade.com ([208.47.132.227])
	by mx0b-000f0801.pphosted.com with ESMTP id 1y1brq36t6-1
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 08 Nov 2015 15:01:03 -0800
From: Anton Ivanov <aivanov@Brocade.com>
Date: Sun, 8 Nov 2015 23:00:59 +0000
Message-ID: <563FD41F.6000308@brocade.com>
References: <1447023037-711-1-git-send-email-aivanov@brocade.com>
In-Reply-To: <1447023037-711-1-git-send-email-aivanov@brocade.com>
Content-Language: en-US
Content-ID: <E07678CC2A95D9429D37147D0E899ECC@brocade.local>
MIME-Version: 1.0
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH] EPOLL Interrupt Controller V2.0
To: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

This works cleanly and is understandable (something I would not say 
about the original version I wrote a couple of years back).

It emits some minor nags on shutdown related to cleaning up the term 
descriptors, but as far as I can see they are mostly harmless. I suspect 
that once I do an incremental on top to enable write IRQ semantics in 
the line.c family of drivers these will go away naturally.

UBD tests out to 15% + faster, net is also faster even if you have one 
device. If you have let's say 20-30 devices, the speed difference 
becomes more substantial even without allocating different IRQs to 
different network devices.

A.

On 08/11/15 22:50, Anton Ivanov wrote:
> Epoll based interrupt controller.
>
> IMPROVES: IO loop performance - no per fd lookups, allowing for
> 15% IO speedup in minimal config going to 100s of % with many
> devices - a N^N lookup is now replaced by a log(N)
>
> ADDS: True Write IRQ functionality
>
> OBSOLETES: The need to call reactivate_fd() in any driver which
> has only read IRQ semantics. Write IRQs work, but will need to
> be updated to use this fully.
>
> Potentially (with a change in API) will allow both edge and level
> IRQ semantics.
>
> Pre-requisite for using packet mmap and multipacket read/write
> which do not get along with poll() very well.
>
> Signed-off-by/: Anton Ivanov <aivanov@brocade.com>
> ---
>   arch/um/drivers/line.c            |   5 +-
>   arch/um/drivers/mconsole_kern.c   |   2 -
>   arch/um/drivers/net_kern.c        |   1 -
>   arch/um/drivers/port_kern.c       |   1 -
>   arch/um/drivers/random.c          |   1 -
>   arch/um/drivers/ubd_kern.c        |   1 -
>   arch/um/include/shared/irq_user.h |  24 ++-
>   arch/um/include/shared/os.h       |  13 +-
>   arch/um/kernel/irq.c              | 412 ++++++++++++++++++++++----------------
>   arch/um/os-Linux/irq.c            | 145 +++++---------
>   10 files changed, 321 insertions(+), 284 deletions(-)
>
> diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
> index 6208702..84384c8 100644
> --- a/arch/um/drivers/line.c
> +++ b/arch/um/drivers/line.c
> @@ -1,4 +1,5 @@
>   /*
> + * Copyright (C) 2012 - 2014 Cisco Systems
>    * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
>    * Licensed under the GPL
>    */
> @@ -283,7 +284,7 @@ int line_setup_irq(int fd, int input, int output, struct line *line, void *data)
>   	if (err)
>   		return err;
>   	if (output)
> -		err = um_request_irq(driver->write_irq, fd, IRQ_WRITE,
> +		err = um_request_irq(driver->write_irq, fd, IRQ_NONE,
>   				     line_write_interrupt, IRQF_SHARED,
>   				     driver->write_irq_name, data);
>   	return err;
> @@ -666,8 +667,6 @@ static irqreturn_t winch_interrupt(int irq, void *data)
>   		tty_kref_put(tty);
>   	}
>    out:
> -	if (winch->fd != -1)
> -		reactivate_fd(winch->fd, WINCH_IRQ);
>   	return IRQ_HANDLED;
>   }
>   
> diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
> index 29880c9..5e8881c 100644
> --- a/arch/um/drivers/mconsole_kern.c
> +++ b/arch/um/drivers/mconsole_kern.c
> @@ -95,7 +95,6 @@ static irqreturn_t mconsole_interrupt(int irq, void *dev_id)
>   	}
>   	if (!list_empty(&mc_requests))
>   		schedule_work(&mconsole_work);
> -	reactivate_fd(fd, MCONSOLE_IRQ);
>   	return IRQ_HANDLED;
>   }
>   
> @@ -243,7 +242,6 @@ void mconsole_stop(struct mc_request *req)
>   		(*req->cmd->handler)(req);
>   	}
>   	os_set_fd_block(req->originating_fd, 0);
> -	reactivate_fd(req->originating_fd, MCONSOLE_IRQ);
>   	mconsole_reply(req, "", 0, 0);
>   }
>   
> diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
> index f70dd54..82ea3a2 100644
> --- a/arch/um/drivers/net_kern.c
> +++ b/arch/um/drivers/net_kern.c
> @@ -137,7 +137,6 @@ static irqreturn_t uml_net_interrupt(int irq, void *dev_id)
>   		schedule_work(&lp->work);
>   		goto out;
>   	}
> -	reactivate_fd(lp->fd, UM_ETH_IRQ);
>   
>   out:
>   	spin_unlock(&lp->lock);
> diff --git a/arch/um/drivers/port_kern.c b/arch/um/drivers/port_kern.c
> index 40ca5cc..b0e9ff3 100644
> --- a/arch/um/drivers/port_kern.c
> +++ b/arch/um/drivers/port_kern.c
> @@ -137,7 +137,6 @@ static void port_work_proc(struct work_struct *unused)
>   		if (!port->has_connection)
>   			continue;
>   
> -		reactivate_fd(port->fd, ACCEPT_IRQ);
>   		while (port_accept(port))
>   			;
>   		port->has_connection = 0;
> diff --git a/arch/um/drivers/random.c b/arch/um/drivers/random.c
> index dd16c90..a392828 100644
> --- a/arch/um/drivers/random.c
> +++ b/arch/um/drivers/random.c
> @@ -72,7 +72,6 @@ static ssize_t rng_dev_read (struct file *filp, char __user *buf, size_t size,
>   				return ret ? : -EAGAIN;
>   
>   			atomic_inc(&host_sleep_count);
> -			reactivate_fd(random_fd, RANDOM_IRQ);
>   			add_sigio_fd(random_fd);
>   
>   			add_wait_queue(&host_read_wait, &wait);
> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
> index e8ab93c..731982c 100644
> --- a/arch/um/drivers/ubd_kern.c
> +++ b/arch/um/drivers/ubd_kern.c
> @@ -466,7 +466,6 @@ static void ubd_handler(void)
>   		blk_end_request(req->req, 0, req->length);
>   		kfree(req);
>   	}
> -	reactivate_fd(thread_fd, UBD_IRQ);
>   
>   	list_for_each_safe(list, next_ele, &restart){
>   		ubd = container_of(list, struct ubd, restart);
> diff --git a/arch/um/include/shared/irq_user.h b/arch/um/include/shared/irq_user.h
> index df56330..0eca64c 100644
> --- a/arch/um/include/shared/irq_user.h
> +++ b/arch/um/include/shared/irq_user.h
> @@ -1,4 +1,5 @@
>   /*
> + * Copyright (C) 2012 - 2014 Cisco Systems
>    * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
>    * Licensed under the GPL
>    */
> @@ -9,16 +10,23 @@
>   #include <sysdep/ptrace.h>
>   
>   struct irq_fd {
> -	struct irq_fd *next;
> -	void *id;
> -	int fd;
> -	int type;
> -	int irq;
> -	int events;
> -	int current_events;
> +        void *id;
> +        int irq;
> +        int events;
> +};
> +
> +
> +#define IRQ_READ  0
> +#define IRQ_WRITE 1
> +#define IRQ_NONE 2
> +#define MAX_IRQ_TYPE (IRQ_NONE + 1)
> +
> +struct irq_entry {
> +        struct irq_entry *next;
> +        int fd;
> +	struct irq_fd * irq_array[MAX_IRQ_TYPE + 1];
>   };
>   
> -enum { IRQ_READ, IRQ_WRITE };
>   
>   struct siginfo;
>   extern void sigio_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs);
> diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
> index 21d704b..3fe1249 100644
> --- a/arch/um/include/shared/os.h
> +++ b/arch/um/include/shared/os.h
> @@ -1,5 +1,6 @@
>   /*
>    * Copyright (C) 2015 Anton Ivanov (aivanov@{brocade.com,kot-begemot.co.uk})
> + * Copyright (C) 2012 - 2014 Cisco Systems
>    * Copyright (C) 2015 Thomas Meyer (thomas@m3y3r.de)
>    * Copyright (C) 2002 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
>    * Licensed under the GPL
> @@ -284,15 +285,17 @@ extern void halt_skas(void);
>   extern void reboot_skas(void);
>   
>   /* irq.c */
> -extern int os_waiting_for_events(struct irq_fd *active_fds);
> -extern int os_create_pollfd(int fd, int events, void *tmp_pfd, int size_tmpfds);
> +
> +extern int os_setup_epoll(int maxevents);
> +extern int os_waiting_for_events_epoll(void *kernel_events, int maxevents);
> +extern int os_add_epoll_fd (int events, int fd, void * data);
> +extern int os_mod_epoll_fd (int events, int fd, void * data);
> +extern int os_del_epoll_fd (int fd);
> +
>   extern void os_free_irq_by_cb(int (*test)(struct irq_fd *, void *), void *arg,
>   		struct irq_fd *active_fds, struct irq_fd ***last_irq_ptr2);
>   extern void os_free_irq_later(struct irq_fd *active_fds,
>   		int irq, void *dev_id);
> -extern int os_get_pollfd(int i);
> -extern void os_set_pollfd(int i, int fd);
> -extern void os_set_ioignore(void);
>   
>   /* sigio.c */
>   extern int add_sigio_fd(int fd);
> diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
> index 23cb935..516b13b 100644
> --- a/arch/um/kernel/irq.c
> +++ b/arch/um/kernel/irq.c
> @@ -1,4 +1,7 @@
>   /*
> + * Copyright (C) 2015 Brocade Communications Ltd
> + *	Author: Anton Ivanov aivanov@{brocade.com,kot-begemot.co.uk}
> + * Copyright (C) 2012 - 2014 Cisco Systems
>    * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
>    * Licensed under the GPL
>    * Derived (i.e. mostly copied) from arch/i386/kernel/irq.c:
> @@ -18,6 +21,61 @@
>   #include <os.h>
>   
>   /*
> +*	We are on the "kernel side" so we cannot pick up the sys/epoll.h
> +*	So we lift out of it the applicable key definitions.
> +*/
> +
> +
> +enum EPOLL_EVENTS
> +  {
> +	EPOLLIN = 0x001,
> +#define EPOLLIN EPOLLIN
> +	EPOLLPRI = 0x002,
> +#define EPOLLPRI EPOLLPRI
> +	EPOLLOUT = 0x004,
> +#define EPOLLOUT EPOLLOUT
> +	EPOLLRDNORM = 0x040,
> +#define EPOLLRDNORM EPOLLRDNORM
> +	EPOLLRDBAND = 0x080,
> +#define EPOLLRDBAND EPOLLRDBAND
> +	EPOLLWRNORM = 0x100,
> +#define EPOLLWRNORM EPOLLWRNORM
> +	EPOLLWRBAND = 0x200,
> +#define EPOLLWRBAND EPOLLWRBAND
> +	EPOLLMSG = 0x400,
> +#define EPOLLMSG EPOLLMSG
> +	EPOLLERR = 0x008,
> +#define EPOLLERR EPOLLERR
> +	EPOLLHUP = 0x010,
> +#define EPOLLHUP EPOLLHUP
> +	EPOLLRDHUP = 0x2000,
> +#define EPOLLRDHUP EPOLLRDHUP
> +	EPOLLONESHOT = (1 << 30),
> +#define EPOLLONESHOT EPOLLONESHOT
> +	EPOLLET = (1 << 31)
> +#define EPOLLET EPOLLET
> +  };
> +
> +
> +typedef union epoll_data
> +{
> +	void *ptr;
> +	int fd;
> +	uint32_t u32;
> +	uint64_t u64;
> +} epoll_data_t;
> +
> +struct epoll_event
> +{
> +	uint32_t events;	/* Epoll events */
> +	epoll_data_t data;	/* User data variable */
> +} __attribute__ ((__packed__));
> +
> +#define MAX_EPOLL_EVENTS 16
> +
> +static struct epoll_event epoll_events[MAX_EPOLL_EVENTS];
> +
> +/*
>    * This list is accessed under irq_lock, except in sigio_handler,
>    * where it is safe from being modified.  IRQ handlers won't change it -
>    * if an IRQ source has vanished, it will be freed by free_irqs just
> @@ -25,44 +83,91 @@
>    * list of irqs to free, with its own locking, coming back here to
>    * remove list elements, taking the irq_lock to do so.
>    */
> -static struct irq_fd *active_fds = NULL;
> -static struct irq_fd **last_irq_ptr = &active_fds;
> +static struct irq_entry *active_fds = NULL;
>   
>   extern void free_irqs(void);
>   
> +
> +static DEFINE_SPINLOCK(irq_lock);
> +
> +
> +/*
> + * Principles of Operation:
> + * Each Epoll structure contains a pointer pointing back to an array
> + * with irq entries for read, write and none and their matching event
> + * masks.
> + * This allows us to stop looking up "who talked"
> + * We no longer need to enable/disable any polls while we process them
> + * epoll will take care of that. The exemption to this (for now) are
> + * character devices because of their own internal buffering, which
> + * needs to be updated to leverage the new write IRQ semantics.
> + * We can now support both read and write IRQs and have separate IRQs
> + * for read and write ops.
> + */
> +
> +
>   void sigio_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
>   {
>   	struct irq_fd *irq_fd;
> -	int n;
> +	struct irq_entry *irq_entry;
> +	unsigned long flags;
> +
> +	int n, i, j;
>   
>   	while (1) {
> -		n = os_waiting_for_events(active_fds);
> -		if (n <= 0) {
> -			if (n == -EINTR)
> -				continue;
> -			else break;
> -		}
>   
> -		for (irq_fd = active_fds; irq_fd != NULL;
> -		     irq_fd = irq_fd->next) {
> -			if (irq_fd->current_events != 0) {
> -				irq_fd->current_events = 0;
> -				do_IRQ(irq_fd->irq, regs);
> -			}
> +		spin_lock_irqsave(&irq_lock, flags);
> +
> +		n = os_waiting_for_events_epoll(
> +			&epoll_events, MAX_EPOLL_EVENTS
> +		);
> +
> +
> + 		if (n <= 0) {
> +			if (n == -EINTR) { continue; }
> +			else { break; }
>   		}
> +
> +
> +		for (i = 0; i < n ; i++) {
> +			/* start from the data ptr, walk the tree branch */
> +			irq_entry = (struct irq_entry *) epoll_events[i].data.ptr;
> +			for (j = 0; j < MAX_IRQ_TYPE ; j ++ ) {
> +				irq_fd = irq_entry->irq_array[j];
> +				if (irq_fd != NULL) {
> +					if (epoll_events[i].events & irq_fd->events) {
> +						do_IRQ(irq_fd->irq, regs);
> +					}
> +				}
> + 			}
> + 		}
> +		spin_unlock_irqrestore(&irq_lock, flags);
>   	}
>   
>   	free_irqs();
>   }
>   
> -static DEFINE_SPINLOCK(irq_lock);
> +static int update_events(struct irq_entry * irq_entry) {
> +	int i;
> +	int events = 0;
> +	struct irq_fd * irq_fd;
> +	for (i = 0; i < MAX_IRQ_TYPE ; i ++ ) {
> +		irq_fd = irq_entry->irq_array[i];
> +		if (irq_fd != NULL) {
> +			events = irq_fd->events | events;
> +		}
> +	}
> +	/* os_add_epoll will call os_mod_epoll if this already exists */
> +	return os_add_epoll_fd(events, irq_entry->fd, irq_entry);
> +}
> +
>   
>   static int activate_fd(int irq, int fd, int type, void *dev_id)
>   {
> -	struct pollfd *tmp_pfd;
> -	struct irq_fd *new_fd, *irq_fd;
> +	struct irq_fd *new_fd;
> +	struct irq_entry * irq_entry;
>   	unsigned long flags;
> -	int events, err, n;
> +	int  i, err, events;
>   
>   	err = os_set_fd_async(fd);
>   	if (err < 0)
> @@ -74,186 +179,150 @@ static int activate_fd(int irq, int fd, int type, void *dev_id)
>   		goto out;
>   
>   	if (type == IRQ_READ)
> -		events = UM_POLLIN | UM_POLLPRI;
> -	else events = UM_POLLOUT;
> -	*new_fd = ((struct irq_fd) { .next  		= NULL,
> -				     .id 		= dev_id,
> -				     .fd 		= fd,
> -				     .type 		= type,
> -				     .irq 		= irq,
> -				     .events 		= events,
> -				     .current_events 	= 0 } );
> -
> -	err = -EBUSY;
> -	spin_lock_irqsave(&irq_lock, flags);
> -	for (irq_fd = active_fds; irq_fd != NULL; irq_fd = irq_fd->next) {
> -		if ((irq_fd->fd == fd) && (irq_fd->type == type)) {
> -			printk(KERN_ERR "Registering fd %d twice\n", fd);
> -			printk(KERN_ERR "Irqs : %d, %d\n", irq_fd->irq, irq);
> -			printk(KERN_ERR "Ids : 0x%p, 0x%p\n", irq_fd->id,
> -			       dev_id);
> -			goto out_unlock;
> -		}
> -	}
> -
> +		events |= EPOLLIN | EPOLLPRI;
>   	if (type == IRQ_WRITE)
> -		fd = -1;
> +		events |= EPOLLOUT;
>   
> -	tmp_pfd = NULL;
> -	n = 0;
> +	*new_fd = ((struct irq_fd) {
> +		.id 		= dev_id,
> +		.irq 		= irq,
> +		.events 	= events
> +	});
>   
> -	while (1) {
> -		n = os_create_pollfd(fd, events, tmp_pfd, n);
> -		if (n == 0)
> -			break;
> +	err = -EBUSY;
>   
> -		/*
> -		 * n > 0
> -		 * It means we couldn't put new pollfd to current pollfds
> -		 * and tmp_fds is NULL or too small for new pollfds array.
> -		 * Needed size is equal to n as minimum.
> -		 *
> -		 * Here we have to drop the lock in order to call
> -		 * kmalloc, which might sleep.
> -		 * If something else came in and changed the pollfds array
> -		 * so we will not be able to put new pollfd struct to pollfds
> -		 * then we free the buffer tmp_fds and try again.
> -		 */
> -		spin_unlock_irqrestore(&irq_lock, flags);
> -		kfree(tmp_pfd);
> +	spin_lock_irqsave(&irq_lock, flags);
>   
> -		tmp_pfd = kmalloc(n, GFP_KERNEL);
> -		if (tmp_pfd == NULL)
> -			goto out_kfree;
> +	for (irq_entry = active_fds; irq_entry != NULL; irq_entry = irq_entry->next) {
> +		if (irq_entry->fd == fd) break;
> +	}
>   
> -		spin_lock_irqsave(&irq_lock, flags);
> +	if (irq_entry == NULL) {
> +		irq_entry = kmalloc(sizeof(struct irq_entry), GFP_KERNEL);
> +		if (irq_entry == NULL) {
> +			printk(KERN_ERR
> +				"Failed to allocate new IRQ entry\n");
> +			kfree(new_fd);
> +			goto out;
> +		}
> +		irq_entry->fd = fd;
> +		for (i = 0; i < MAX_IRQ_TYPE; i++) {
> +			irq_entry->irq_array[i] = NULL;
> +		}
> +		irq_entry->next = active_fds;
> +		active_fds = irq_entry;
>   	}
>   
> -	*last_irq_ptr = new_fd;
> -	last_irq_ptr = &new_fd->next;
> +	if (irq_entry->irq_array[type] != NULL) {
> +		printk(KERN_ERR
> +			"Trying to reregister IRQ %d FD %d TYPE %d ID %p\n",
> +			irq, fd, type, dev_id
> +		);
> +		goto out_unlock;
> +	} else {
> +		irq_entry->irq_array[type] = new_fd;
> +	}
>   
> +	update_events(irq_entry);
> +	
>   	spin_unlock_irqrestore(&irq_lock, flags);
>   
> -	/*
> -	 * This calls activate_fd, so it has to be outside the critical
> -	 * section.
> -	 */
> -	maybe_sigio_broken(fd, (type == IRQ_READ));
> +	maybe_sigio_broken(fd, (type != IRQ_NONE));
>   
>   	return 0;
>   
>    out_unlock:
>   	spin_unlock_irqrestore(&irq_lock, flags);
> - out_kfree:
>   	kfree(new_fd);
>    out:
>   	return err;
>   }
>   
> -static void free_irq_by_cb(int (*test)(struct irq_fd *, void *), void *arg)
> -{
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&irq_lock, flags);
> -	os_free_irq_by_cb(test, arg, active_fds, &last_irq_ptr);
> -	spin_unlock_irqrestore(&irq_lock, flags);
> -}
> -
> -struct irq_and_dev {
> -	int irq;
> -	void *dev;
> -};
>   
> -static int same_irq_and_dev(struct irq_fd *irq, void *d)
> +static void do_free_by_irq_and_dev(
> +	struct irq_entry* irq_entry,
> +	unsigned int irq,
> +	void * dev
> +)
>   {
> -	struct irq_and_dev *data = d;
> -
> -	return ((irq->irq == data->irq) && (irq->id == data->dev));
> +	int i;
> +	struct irq_fd * to_free;
> +	for (i = 0; i < MAX_IRQ_TYPE ; i ++ ) {
> +		if (irq_entry->irq_array[i] != NULL) {
> +			if (
> +				(irq_entry->irq_array[i]->irq == irq) &&
> +				(irq_entry->irq_array[i]->id == dev)
> +			) {
> +				to_free = irq_entry->irq_array[i];
> +				irq_entry->irq_array[i] = NULL;
> +				update_events(irq_entry);
> +				kfree(to_free);
> +			}
> +		}
> +	}
>   }
>   
> -static void free_irq_by_irq_and_dev(unsigned int irq, void *dev)
> -{
> -	struct irq_and_dev data = ((struct irq_and_dev) { .irq  = irq,
> -							  .dev  = dev });
> +void free_irq_by_fd(int fd) {
>   
> -	free_irq_by_cb(same_irq_and_dev, &data);
> -}
> +	struct irq_entry *irq_entry, *prev = NULL;
> +	unsigned long flags;
> +	int i;
>   
> -static int same_fd(struct irq_fd *irq, void *fd)
> -{
> -	return (irq->fd == *((int *)fd));
> +	spin_lock_irqsave(&irq_lock, flags);
> +	for (irq_entry = active_fds; irq_entry != NULL; irq_entry = irq_entry->next) {
> +		if (irq_entry->fd == irq_entry->fd) {
> +			os_del_epoll_fd(fd);   /* ignore err, just do it */
> +			for (i = 0; i < MAX_IRQ_TYPE ; i++) {
> +				if (irq_entry->irq_array[i] != NULL) {
> +					kfree(irq_entry->irq_array[i]);
> +				}
> +			}
> +			if (prev == NULL) {
> +				active_fds = irq_entry->next;
> +			} else {
> +				prev->next = irq_entry->next;
> +			}
> +			kfree(irq_entry);
> +		} else {
> +			prev = irq_entry;
> +		}
> +	}
> +	spin_unlock_irqrestore(&irq_lock, flags);
> +	
>   }
>   
> -void free_irq_by_fd(int fd)
> -{
> -	free_irq_by_cb(same_fd, &fd);
> -}
>   
> -/* Must be called with irq_lock held */
> -static struct irq_fd *find_irq_by_fd(int fd, int irqnum, int *index_out)
> -{
> -	struct irq_fd *irq;
> -	int i = 0;
> -	int fdi;
> -
> -	for (irq = active_fds; irq != NULL; irq = irq->next) {
> -		if ((irq->fd == fd) && (irq->irq == irqnum))
> -			break;
> -		i++;
> -	}
> -	if (irq == NULL) {
> -		printk(KERN_ERR "find_irq_by_fd doesn't have descriptor %d\n",
> -		       fd);
> -		goto out;
> -	}
> -	fdi = os_get_pollfd(i);
> -	if ((fdi != -1) && (fdi != fd)) {
> -		printk(KERN_ERR "find_irq_by_fd - mismatch between active_fds "
> -		       "and pollfds, fd %d vs %d, need %d\n", irq->fd,
> -		       fdi, fd);
> -		irq = NULL;
> -		goto out;
> -	}
> -	*index_out = i;
> - out:
> -	return irq;
> -}
> +static void free_irq_by_irq_and_dev(unsigned int irq, void *dev) {
>   
> -void reactivate_fd(int fd, int irqnum)
> -{
> -	struct irq_fd *irq;
> +	struct irq_entry *irq_entry;
>   	unsigned long flags;
> -	int i;
>   
>   	spin_lock_irqsave(&irq_lock, flags);
> -	irq = find_irq_by_fd(fd, irqnum, &i);
> -	if (irq == NULL) {
> -		spin_unlock_irqrestore(&irq_lock, flags);
> -		return;
> +	for (irq_entry = active_fds; irq_entry != NULL; irq_entry = irq_entry->next) {
> +		do_free_by_irq_and_dev(irq_entry, irq, dev);
>   	}
> -	os_set_pollfd(i, irq->fd);
>   	spin_unlock_irqrestore(&irq_lock, flags);
> -
> -	add_sigio_fd(fd);
> +	
>   }
>   
> -void deactivate_fd(int fd, int irqnum)
> +
> +void reactivate_fd(int fd, int irqnum)
>   {
> -	struct irq_fd *irq;
> +	struct irq_entry *irq_entry;
>   	unsigned long flags;
> -	int i;
> -
>   	spin_lock_irqsave(&irq_lock, flags);
> -	irq = find_irq_by_fd(fd, irqnum, &i);
> -	if (irq == NULL) {
> -		spin_unlock_irqrestore(&irq_lock, flags);
> -		return;
> +	for (irq_entry = active_fds; irq_entry != NULL; irq_entry = irq_entry->next) {
> +		if (irq_entry->fd == fd) {
> +			update_events(irq_entry);
> +		}
>   	}
> -
> -	os_set_pollfd(i, -1);
>   	spin_unlock_irqrestore(&irq_lock, flags);
> +	
> +}
>   
> -	ignore_sigio_fd(fd);
> +void deactivate_fd(int fd, int irqnum)
> +{
> +	os_del_epoll_fd(fd);   /* ignore err, just do it */
>   }
>   EXPORT_SYMBOL(deactivate_fd);
>   
> @@ -265,17 +334,16 @@ EXPORT_SYMBOL(deactivate_fd);
>    */
>   int deactivate_all_fds(void)
>   {
> -	struct irq_fd *irq;
> +	struct irq_entry * irq_entry;
>   	int err;
>   
> -	for (irq = active_fds; irq != NULL; irq = irq->next) {
> -		err = os_clear_fd_async(irq->fd);
> -		if (err)
> -			return err;
> +	for (irq_entry = active_fds; irq_entry != NULL; irq_entry = irq_entry->next) {
> +		os_del_epoll_fd(irq_entry->fd);   /* ignore err, just do it */
> +		err = os_clear_fd_async(irq_entry->fd);
> +		if (err) {
> +			printk(KERN_ERR "Clear FD async failed with %d", err);
> +		}
>   	}
> -	/* If there is a signal already queued, after unblocking ignore it */
> -	os_set_ioignore();
> -
>   	return 0;
>   }
>   
> @@ -308,13 +376,13 @@ int um_request_irq(unsigned int irq, int fd, int type,
>   {
>   	int err;
>   
> -	if (fd != -1) {
> +	err = request_irq(irq, handler, irqflags, devname, dev_id);
> +
> +	if ((!err) && (fd != -1)) {
>   		err = activate_fd(irq, fd, type, dev_id);
> -		if (err)
> -			return err;
>   	}
>   
> -	return request_irq(irq, handler, irqflags, devname, dev_id);
> +	return err;
>   }
>   
>   EXPORT_SYMBOL(um_request_irq);
> @@ -352,9 +420,9 @@ void __init init_IRQ(void)
>   	int i;
>   
>   	irq_set_chip_and_handler(TIMER_IRQ, &SIGVTALRM_irq_type, handle_edge_irq);
> -
> -	for (i = 1; i < NR_IRQS; i++)
> +	for (i = 1; i < NR_IRQS - 1 ; i++)
>   		irq_set_chip_and_handler(i, &normal_irq_type, handle_edge_irq);
> +	os_setup_epoll(MAX_EPOLL_EVENTS);
>   }
>   
>   /*
> @@ -382,11 +450,11 @@ void __init init_IRQ(void)
>    * thread_info.
>    *
>    * There are three cases -
> - *     The first interrupt on the stack - sets up the thread_info and
> + *	 The first interrupt on the stack - sets up the thread_info and
>    * handles the interrupt
> - *     A nested interrupt interrupting the copying of the thread_info -
> + *	 A nested interrupt interrupting the copying of the thread_info -
>    * can't handle the interrupt, as the stack is in an unknown state
> - *     A nested interrupt not interrupting the copying of the
> + *	 A nested interrupt not interrupting the copying of the
>    * thread_info - doesn't do any setup, just handles the interrupt
>    *
>    * The first job is to figure out whether we interrupted stack setup.
> diff --git a/arch/um/os-Linux/irq.c b/arch/um/os-Linux/irq.c
> index b9afb74..837aa68 100644
> --- a/arch/um/os-Linux/irq.c
> +++ b/arch/um/os-Linux/irq.c
> @@ -1,4 +1,5 @@
>   /*
> + * Copyright (C) 2012 - 2014 Cisco Systems
>    * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
>    * Licensed under the GPL
>    */
> @@ -6,6 +7,7 @@
>   #include <stdlib.h>
>   #include <errno.h>
>   #include <poll.h>
> +#include <sys/epoll.h>
>   #include <signal.h>
>   #include <string.h>
>   #include <irq_user.h>
> @@ -16,117 +18,80 @@
>    * Locked by irq_lock in arch/um/kernel/irq.c.  Changed by os_create_pollfd
>    * and os_free_irq_by_cb, which are called under irq_lock.
>    */
> -static struct pollfd *pollfds = NULL;
> -static int pollfds_num = 0;
> -static int pollfds_size = 0;
>   
> -int os_waiting_for_events(struct irq_fd *active_fds)
> +/* epoll support */
> +
> +
> +static int epollfd = -1;
> +
> +int os_setup_epoll(int maxevents) {
> +	epollfd = epoll_create(maxevents);
> +	return epollfd;
> +}
> +
> +int os_waiting_for_events_epoll(void *kernel_events, int maxevents)
>   {
> -	struct irq_fd *irq_fd;
> -	int i, n, err;
> +	int n, err;
>   
> -	n = poll(pollfds, pollfds_num, 0);
> +	n = epoll_wait(epollfd,
> +		(struct epoll_event *) kernel_events, maxevents, 0);
>   	if (n < 0) {
>   		err = -errno;
>   		if (errno != EINTR)
> -			printk(UM_KERN_ERR "os_waiting_for_events:"
> -			       " poll returned %d, errno = %d\n", n, errno);
> +			printk(
> +				UM_KERN_ERR "os_waiting_for_events:"
> +				" poll returned %d, error = %s\n", n,
> +				strerror(errno)
> +			);
>   		return err;
>   	}
>   
> -	if (n == 0)
> -		return 0;
> -
> -	irq_fd = active_fds;
> -
> -	for (i = 0; i < pollfds_num; i++) {
> -		if (pollfds[i].revents != 0) {
> -			irq_fd->current_events = pollfds[i].revents;
> -			pollfds[i].fd = -1;
> -		}
> -		irq_fd = irq_fd->next;
> -	}
>   	return n;
>   }
>   
> -int os_create_pollfd(int fd, int events, void *tmp_pfd, int size_tmpfds)
> -{
> -	if (pollfds_num == pollfds_size) {
> -		if (size_tmpfds <= pollfds_size * sizeof(pollfds[0])) {
> -			/* return min size needed for new pollfds area */
> -			return (pollfds_size + 1) * sizeof(pollfds[0]);
> -		}
> -
> -		if (pollfds != NULL) {
> -			memcpy(tmp_pfd, pollfds,
> -			       sizeof(pollfds[0]) * pollfds_size);
> -			/* remove old pollfds */
> -			kfree(pollfds);
> -		}
> -		pollfds = tmp_pfd;
> -		pollfds_size++;
> -	} else
> -		kfree(tmp_pfd);	/* remove not used tmp_pfd */
> +int os_add_epoll_fd (int events, int fd, void * data) {
> +	struct epoll_event event;
> +	int result;
>   
> -	pollfds[pollfds_num] = ((struct pollfd) { .fd		= fd,
> -						  .events	= events,
> -						  .revents	= 0 });
> -	pollfds_num++;
> -
> -	return 0;
> +	event.data.ptr = data;
> +	event.events = events | EPOLLET;
> +	result = epoll_ctl(epollfd, EPOLL_CTL_ADD, fd, &event);
> +	if ((result) && (errno == EEXIST)) {
> +		result = os_mod_epoll_fd (events, fd, data);
> +	}
> +	if (result) {
> +		printk("epollctl add err fd %d, %s\n", fd, strerror(errno));
> +	}
> +	return result;
>   }
>   
> -void os_free_irq_by_cb(int (*test)(struct irq_fd *, void *), void *arg,
> -		struct irq_fd *active_fds, struct irq_fd ***last_irq_ptr2)
> -{
> -	struct irq_fd **prev;
> -	int i = 0;
> -
> -	prev = &active_fds;
> -	while (*prev != NULL) {
> -		if ((*test)(*prev, arg)) {
> -			struct irq_fd *old_fd = *prev;
> -			if ((pollfds[i].fd != -1) &&
> -			    (pollfds[i].fd != (*prev)->fd)) {
> -				printk(UM_KERN_ERR "os_free_irq_by_cb - "
> -				       "mismatch between active_fds and "
> -				       "pollfds, fd %d vs %d\n",
> -				       (*prev)->fd, pollfds[i].fd);
> -				goto out;
> -			}
> -
> -			pollfds_num--;
> -
> -			/*
> -			 * This moves the *whole* array after pollfds[i]
> -			 * (though it doesn't spot as such)!
> -			 */
> -			memmove(&pollfds[i], &pollfds[i + 1],
> -			       (pollfds_num - i) * sizeof(pollfds[0]));
> -			if (*last_irq_ptr2 == &old_fd->next)
> -				*last_irq_ptr2 = prev;
> -
> -			*prev = (*prev)->next;
> -			if (old_fd->type == IRQ_WRITE)
> -				ignore_sigio_fd(old_fd->fd);
> -			kfree(old_fd);
> -			continue;
> -		}
> -		prev = &(*prev)->next;
> -		i++;
> +int os_mod_epoll_fd (int events, int fd, void * data) {
> +	struct epoll_event event;
> +	int result;
> +	event.data.ptr = data;
> +	event.events = events;
> +	result = epoll_ctl(epollfd, EPOLL_CTL_MOD, fd, &event);
> +	if (result) {
> +		printk("epollctl mod err fd %d, %s\n", fd, strerror(errno));
>   	}
> - out:
> -	return;
> +	return result;
>   }
>   
> -int os_get_pollfd(int i)
> -{
> -	return pollfds[i].fd;
> +int os_del_epoll_fd (int fd) {
> +	struct epoll_event event;
> +	int result;
> +	result = epoll_ctl(epollfd, EPOLL_CTL_DEL, fd, &event);
> +	if (result) {
> +		printk("epollctl del err %s\n", strerror(errno));
> +	}
> +	return result;
>   }
>   
> -void os_set_pollfd(int i, int fd)
> +void os_free_irq_by_cb(int (*test)(struct irq_fd *, void *), void *arg,
> +		struct irq_fd *active_fds, struct irq_fd ***last_irq_ptr2)
>   {
> -	pollfds[i].fd = fd;
> +	printk("Someone invoking obsolete deactivate_by_CB!!!\n");
> +	return;
>   }
>   
>   void os_set_ioignore(void)

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

