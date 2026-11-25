Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C03606A691
	for <linux-um@archiver.kernel.org>; Wed, 25 Nov 2026 16:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UU6QOdZu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=tSxh6DwLNmz7EyfDz5NfHF0oAWvGew0gIHmykfmlnJY=; b=UU6QOdZuY0/1Lz
	6Mxc+q4XDsUTS2otQb9IMCKCSw1jcGsF8nDCIYtd1t6lHcrcooR7XjTzaK5EBpwrvAbOtfb0HqU3J
	0LUxJxUmP45zy6OpXgMTuall5jrXA62X15yBiKWSBqvGMdvD73K/VXPaNZHAgnKDwWFQdzd+bqsbg
	CcC2weBoH0oVEUsi9tITJM4mrzglmcX0EG2y04l4EActG64X7Vkz7tFnqGy5T6p9QeX5pMp+zD1q2
	Yu9CD1hm4doyUk+TFwsU9QRXcRd3A3f8+wQ378TALbv0/Q5ZBlAxhtDMltoF76CKMn9TpIfI3c9hF
	djHuOS66/IJfRHXAvZ2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWFtI-0000000AZZD-2CCb;
	Wed, 25 Nov 2026 16:30:40 +0000
Received: from ns3.kot-begemot.co.uk ([31.70.137.218])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWFt1-0000000AZGD-0sWz
	for linux-um@lists.infradead.org;
	Wed, 25 Nov 2026 16:30:37 +0000
Received: from [192.168.19.6] (helo=jain.kot-begemot.co.uk)
	by ns3.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1xWFsv-00000002fOj-3i0W;
	Wed, 25 Nov 2026 16:30:18 +0000
Received: from [192.168.21.17]
	by jain.kot-begemot.co.uk with esmtp (Exim 4.98.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1xWFcP-00000001ZP4-02ls;
	Wed, 25 Nov 2026 16:30:16 +0000
Message-ID: <2a8cbf32-4fd3-4aaf-87dd-6a2a7638f6c9@cambridgegreys.com>
Date: Wed, 25 Nov 2026 16:30:14 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_UML=3A_/proc/net/netstat_silently_mis-read_by_stdio?=
 =?UTF-8?Q?_line_readers_=28fgets/getline=29_=E2=80=94_raw_reads_of_every_si?=
 =?UTF-8?Q?ze_are_byte-exact=2C_all_other_/proc_files_are_unaffected?=
To: Johan ter Mors <johan.termors@gmail.com>, linux-um@lists.infradead.org
Cc: richard@nod.at, johannes@sipsolutions.net
References: <CAPM+r-Jaz9c0d1F3QP_5aZDnRMGVmzWDrp-FMUcvUv5e2RpB_g@mail.gmail.com>
Content-Language: en-US
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <CAPM+r-Jaz9c0d1F3QP_5aZDnRMGVmzWDrp-FMUcvUv5e2RpB_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261125_083023_440396_FC48D2A0 
X-CRM114-Status: GOOD (  30.18  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 25/11/2026 16:24, Johan ter Mors wrote:
> [Quick note before the report: my earlier mail of today carried a
> mangled Subject header — my mail client put the intended maintainer
> Cc addresses into the subject line, so the report went out without a
> usable subject and without the maintainer Cc. This thread is the same
> report with a corrected envelope; please treat this copy as the
> report. The mangled original is archived here, for the record:
> 
> https://lore.kernel.org/linux-um/CAPM+r-+XCeM01ZXAj8Cti5qL1iaFrGrV+dYSumWD8585O3swew@mail.gmail.com/
> ]
> 
> Hi,
> 
> While parsing TcpExt counters inside our lab guests (own lean UML
> builds), we hit a reproducible case where stdio line readers (fgets
> and getline) silently mis-read /proc/net/netstat — while every raw
> read of the same file, on the same boot, is byte-exact. The same
> statically linked binary behaves correctly on a non-UML host kernel.
> We have not found an earlier report, so here is the full picture. We
> could not pin the final mechanism; the data is attached so you can
> judge it directly.
> 
> Observed:
> 
>    - Which stdio call mis-assembles varies per process instance of the
>      same binary; within one instance it is deterministic per fopen.
>      Captured byte-exactly across instances on 7.3.6 and 6.12.117:
>        * fgets(buf, 16384) mis-assembles in most instances. Two shapes:
>            (i) the TcpExt *names* record is lost except its first byte,
>                which fuses onto the next record: the stream starts
>                "TTcpExt: 0 0 ...". 2002 of 4197 bytes on 7.3.6; 1718 of
>                3862 on 6.12.117 — exactly the names-line length is
>                missing, and memcmp proves the output is the pure
>                subsequence "T" + rest-of-file;
>            (ii) full-length output (4197/4197) in which the names
>                string is absent and 16-byte windows exist that appear
>                NOWHERE in the file — the reader's own stale process
>                memory mixed into the assembled stream.
>        * In other instances fgets(buf, 4096) mis-assembled (names-line
>          length missing, plus foreign windows) while fgets(buf, 16384)
>          was byte-exact in the same process; in another instance
>          getline() returned full-length output with foreign windows.
>          So no fgets size is a safe workaround.
>        * Three fresh fopen() repeats of fgets(16384) in one instance
>          where the earlier calls were all byte-exact stayed correct —
>          but we have not seen a rule predicting which instance fails.
>    - Scope sweep, both UML kernels: 20 /proc files (net/netstat, snmp,
>      dev, sockstat, softnet_stat, tcp, udp, unix, mounts, cpuinfo,
>      version, self/limits, self/status, vmstat, meminfo, stat, uptime,
>      loadavg, ...) x 6 reader patterns (getline, fgets 512/4096/16384/
>      65536, fread 16384): every file reads byte-exact with every
>      pattern EXCEPT /proc/net/netstat.
>    - fread(buf, 16384) and explicit setvbuf() configurations (4096/
>      8192/16384-byte buffers, _IONBF, _IOLBF) have so far never
>      mis-assembled (limited number of instances observed), and raw
>      read() is byte-exact in every pattern we tried: single reads of
>      18 sizes (2048 .. 131072) at offset 0, sequential pairs, and
>      lseek(K)+read() sweeps across the record boundaries — on the same
>      boots where stdio mis-assembles.
>    - The identical binary on a non-UML host kernel (5.10.134) is
>      correct for every pattern in every instance.
>    - Reproduces on 6.12.117, 7.3.5 and 7.3.6 UML (own lean builds;
>      defconfig + MPTCP/HOSTFS/BLK_DEV_INITRD/RD_GZIP/VETH/NET_NS, and
>      SYN_COOKIES/IPV6 on 7.3.6; DEBUG_INFO/BTF off; two small
>      ptrace-only lab patches that do not touch procfs).
>    - We do not have a non-UML kernel >= 6.12 in this lab (no
>      hypervisor), so a stock-kernel control is still open — running the
>      reproducer on any regular 6.12/7.x box would pin the scope nicely.
> 
> Security note: we checked this explicitly before reporting. The
> mis-assembled output contains only file bytes plus, in the mixing
> shape, the reader's own stale process memory — never anything outside
> the reading process (the kernel's raw read path is byte-exact on the
> same boots, verified down to writes into stack buffers; memcmp
> controls prove the file content was stable). No crash, no splat, no
> privilege effect in any run; the reader is its own only victim. So we
> do not consider this a security issue — it is a correctness bug for
> common parsing patterns, and monitoring agents parsing
> /proc/net/netstat with stdio on UML silently lose the TcpExt field
> names.
> 
> Minimal reproducer (static glibc, reads the file, prints three
> numbers):
> 
> #define _GNU_SOURCE
> #include <stdio.h>
> #include <string.h>
> int main(void) {
>      FILE *f = fopen("/proc/net/netstat", "r");
>      static char line[16384], all[65536];
>      int tot = 0, l1 = -1;
>      while (fgets(line, sizeof line, f)) {
>          int n = (int)strlen(line);
>          if (l1 < 0) l1 = n;
>          if (tot + n < (int)sizeof all) { memcpy(all + tot, line, n); tot += n; }
>      }
>      printf("first-line=%d total=%d names=%s\n", l1, tot,
>             tot > 0 && memmem(all, tot, "SyncookiesSent", 14) ? "yes" : "NO");
>      return 0;
> }
> 
> On UML 7.3.6, failing instance A:  first-line=1 total=2002 names=NO
>                                     (names lost, fused)
> On UML 7.3.6, failing instance B:  first-line=2196 total=4197 names=NO
>                                     (full length, stale-memory mixing)
> Correct instance of the same binary on the same guest:
>                                     first-line=2196 total=4197 names=yes
> 
> Because every raw read of the same file is correct on the same boots,
> we suspect the fault sits in the interaction between the UML
> syscall-return delivery and glibc stdio's line assembly rather than in
> seq_file's data path; the per-instance randomness (same binary, same
> pattern, byte-exact in one instance and mis-assembled in the next)
> suggests the failure depends on the reader process's layout/state. We
> cannot split that further from user space, and a ptrace-based tracer
> on UML is not a reliable witness (the guest kernel already ptraces its
> own user processes for syscall emulation, so a second ptrace layer
> distorts what it observes).
> 
> Kernel log clean on all runs; happy to provide the full diagnostic
> sources, serial logs and the saved UML vmlinux files, and to test
> patches or hypotheses.
> 
> Thanks,
> Johan ter Mors — independent researcher
> 
> 

I have never observed this. Quick question - can you reproduce it with a kernel build without multipath TCP?

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661

