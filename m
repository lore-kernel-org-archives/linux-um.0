Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZC1k-00Cryz-En
 for linux-um@lists.infradead.org; Wed, 21 Apr 2021 12:32:24 +0000
Subject: Re: Race between SIGIO and epoll from SMP host
References: <CABqSeARcB3hZZ=qrWCOUSqVnGLcSohzm-L2_8J6BZB+Tsh0zGw@mail.gmail.com>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <d26d976f-2ef0-aeec-e2f4-51b171e0a069@kot-begemot.co.uk>
Date: Wed, 21 Apr 2021 13:32:10 +0100
MIME-Version: 1.0
In-Reply-To: <CABqSeARcB3hZZ=qrWCOUSqVnGLcSohzm-L2_8J6BZB+Tsh0zGw@mail.gmail.com>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: YiFei Zhu <zhuyifei1999@gmail.com>, linux-um@lists.infradead.org



On 21/04/2021 12:53, YiFei Zhu wrote:
> Hi
> 
> I was playing around with xxd large files when I noticed that the
> terminal output often stalls for a few seconds. It's a heisenbug so
> the root cause was mostly found by debugging-by-printing and
> trial-and-error.
> 
> This bug I can reliably reproduce by running `xxd /dev/zero` inside
> UML that has its tty as `fd:0,fd:1`. Behavior: the terminal output
> stalls in the middle of a line, stalling for seconds and possibly a
> very long time. Keyboard input de-stalls the output but will stall
> again quickly.
> 
> AFAICT, the way UML receives CONSOLE_WRITE_IRQ from stdout is that, it
> sets O_ASYNC on stdout, then whenever a SIGIO is received by UML, it
> checks for the origin of the SIGIO via epoll_wait in
> os_waiting_for_events_epoll. However, this is racy: A SIGIO can be
> generated prior to epoll receiving the event, so epoll_wait with zero
> timeout may be called before epoll receives the event, and the event
> can be missed.
> 
> As a minimal reproducible example, this C code running on the host
> often assert failure in `res == 1`:
> 
> [snip]
> #define _GNU_SOURCE 1
> 
> #include <assert.h>
> #include <errno.h>
> #include <stdio.h>
> #include <signal.h>
> #include <sys/epoll.h>
> #include <sys/fcntl.h>
> #include <unistd.h>
> 
> #define MAX_EPOLL_EVENTS 64
> volatile sig_atomic_t state;
> static struct epoll_event epoll_events[MAX_EPOLL_EVENTS];
> 
> static char msg[] =
>      "00000000: 0000 0000 0000 0000 0000 0000 0000 0000  ................\n";
> 
> static void sigio_handler(int ignored)
> {
>      assert(state == 1 || state == 0);
>      state = 2;
> }
> 
> int main(int argc, char **argv)
> {
>      int epollfd, flags, res;
>      struct epoll_event event;
> 
>      state = 0;
> 
>      signal(SIGIO, sigio_handler);
> 
>      epollfd = epoll_create(MAX_EPOLL_EVENTS);
>      assert(epollfd >= 0);
> 
>      event.data.ptr = NULL;
>      event.events = EPOLLOUT | EPOLLET;
>      assert(!epoll_ctl(epollfd, EPOLL_CTL_ADD, 1, &event));
> 
>      flags = fcntl(1, F_GETFL);
>      assert(flags >= 0);
>      flags |= O_ASYNC | O_NONBLOCK;
> 
>      assert(!fcntl(1, F_SETFL, flags));
>      assert(!fcntl(1, F_SETSIG, SIGIO));
>      assert(!fcntl(1, F_SETOWN, getpid()));
> 
>      for (;;) {
>          if (state == 0) {
>              res = write(1, msg, sizeof(msg));
>              if (res < 0 && errno == EAGAIN)
>                  state = 1;
>          } else if (state == 1) {
>              pause();
>          } else if (state == 2) {
>              res = epoll_wait(epollfd, epoll_events, MAX_EPOLL_EVENTS, 1);
>              assert(res == 1);
>              state = 0;
>          }
>      }
> }
> [/snip]
> 
> strace -e epoll_wait shows, the last few lines:
> 
>    --- SIGIO {si_signo=SIGIO, si_code=POLL_OUT, si_band=772} ---
>    epoll_wait(3, [{events=EPOLLOUT, data={u32=0, u64=0}}], 64, 1) = 1
>    --- SIGIO {si_signo=SIGIO, si_code=POLL_OUT, si_band=772} ---
>    epoll_wait(3, [{events=EPOLLOUT, data={u32=0, u64=0}}], 64, 1) = 1
>    --- SIGIO {si_signo=SIGIO, si_code=POLL_OUT, si_band=772} ---
>    epoll_wait(3, [], 64, 1)                = 0
>    --- SIGABRT {si_signo=SIGABRT, si_code=SI_TKILL, si_pid=2033614,
> si_uid=1000} ---
>    +++ killed by SIGABRT (core dumped) +++
> 
> I reproduced this assertion failure on:
> * a self-built 5.11.14 SMP vanilla kernel running on bare metal, with
> terminal as a graphical application.
> * a 4.19.0-0.bpo.14-amd64 Debian 4.19.171-2~deb9u1 SMP kernel with
> terminal as ssh terminal.
> 
> Can still reproduce after setting timeout to 1 ms, in both in UML and
> in this minimal example.
> 
> I looked into how SIGIO and epoll events are generated for a tty, and
> it seems that SIGIO is generated strictly before epoll events are
> generated. gdb backtrace looks like (yes, on UML; didn't bother to
> spin up qemu since I had a UML gdb open):
> 
>    #0  send_sigio (fown=0x674a4b98, fd=0x1, band=0x2) at ./fs/fcntl.c:795
>    #1  kill_fasync_rcu (band=<optimized out>, sig=<optimized out>,
> fa=0x672f90c0) at ./fs/fcntl.c:1019
>    #2  kill_fasync (fp=<optimized out>, sig=0x1d, band=0x2) at ./fs/fcntl.c:1033
>    #3  n_tty_write_wakeup (tty=<optimized out>) at ./drivers/tty/n_tty.c:243
>    #4  tty_wakeup (tty=0x67485800) at ./drivers/tty/tty_io.c:533
>    #5  tty_port_default_wakeup (port=<optimized out>) at
> ./drivers/tty/tty_port.c:50
>    #6  tty_port_tty_wakeup (port=0x615ded80 <vts>) at
> ./drivers/tty/tty_port.c:388
> 
>    #0  ep_poll_callback (wait=0x674d2ad0, mode=0x1, sync=0x0, key=0x4)
> at ./fs/eventpoll.c:361
>    #1  __wake_up_common (wq_head=0x67485ce8, mode=0x1,
> nr_exclusive=0x1, wake_flags=0x0, key=0x4, bookmark=0x61396f70) at
> ./kernel/sched/wait.c:108
>    #2  __wake_up_common_lock (wq_head=0x67485ce8, mode=0x1,
> nr_exclusive=0x1, wake_flags=0x0, key=0x4) at
> ./kernel/sched/wait.c:138
>    #3  __wake_up (wq_head=0x67485ce8, mode=0x1, nr_exclusive=0x1,
> key=0x4) at ./kernel/sched/wait.c:157
>    #4  tty_wakeup (tty=0x67485800) at ./drivers/tty/tty_io.c:537
>    #5  tty_port_default_wakeup (port=<optimized out>) at
> ./drivers/tty/tty_port.c:50
>    #6  tty_port_tty_wakeup (port=0x615ded80 <vts>) at
> ./drivers/tty/tty_port.c:388
> 
> The last shared frame is in tty_wakeup, and n_tty_write_wakeup is
> called by `ld->ops->write_wakeup` whereas __wake_up is in the macro
> wake_up_interruptible_poll, so send_sigio is called strictly before
> ep_poll_callback for tty_wakeup.
> 
> I have not tested on a non-SMP host, but on an SMP host, SIGIO could
> cause the waiting task to wake up on a different core, and the task
> could invoke epoll_wait before the interrupt handler generates the
> epoll event in ep_poll_callback. If this happens to UML, the interrupt
> for UML to make the tty ready will be missed until the next SIGIO.
> 
> Considering that this is a race on the host, what would be the best
> way to fix this?

Interesting one. I need to think.

One option would be to wait for epoll events with a timeout which is larger than zero - f.e. HZ.

If we have received a SIGIO there is an epoll event on the way. The fact that it is not in the queue right now means that we are due to process it shortly.

A.

> 
> YiFei Zhu
> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
> 

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

