Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A709F606A31C
	for <linux-um@archiver.kernel.org>; Thu, 26 Nov 2026 16:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=YUZbZN5k;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c4m7kfKI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=H3EJuqeRE2ICIwkh8UfM3ZgpmiaT2NjwHfTW5cfwv8w=; b=YUZbZN5kTPTnkX
	c8Fns6KDJFAnOTXoMDRxzKcgLSkkBtYa0B9si3DtALt05xQuaN7faIjpJLzX7lx9PK6dF9RwZfMJM
	WybKB3G1uwZARKE8qXKq4lNnYX49IKD7VfWBNLgJaVgy4K5oE8TyK4wckBLcVRlEHpay6L66EOdfl
	2gvzSTMzC6m6YWedk6sSrfM8TIBTSp9ub88m/5KXmfWQJ7IHNJj0vtIGgcidg93NXp4geqaVYLbXl
	gmpeB/X1N988/C5gPOOe1xZAefIoOWy4ADSeZ/6gk1NR9GcuvqA34z0oH7hjFoqaaGX2yO3Chy157
	JLPF2ovVR6n2H0tQo7WA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWbxH-0000000DquD-0DRf;
	Thu, 26 Nov 2026 16:04:15 +0000
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWGYw-0000000AgoF-0Apu
	for linux-um@lists.infradead.org;
	Wed, 25 Nov 2026 17:13:44 +0000
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-c505994e5f5so92086866b.1
        for <linux-um@lists.infradead.org>; Wed, 25 Nov 2026 09:13:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795626818; cv=none;
        d=google.com; s=arc-20260327;
        b=HnHPTsVI0n40JEKeZJ4C8kjGdhUVdiIDRJF08VaqwGJbstOrnbDCxbL91GEdFqTbRX
         75SPHFhYIXFSmC2T0AdmURxstSLiS6MQFAelLxAK0bQ5rchu7C2Fhf5MbFlmHXtsNS4b
         YcY7+EBR2NlUoWETg2y1JR2gc3eC62ktnxO3V9zRD4+DWQSVdItq6fJvNJBP1gH3et7e
         z2PIYTER/R2a0tsBmlZWgXWAza86Z3Rkf4Nvm8N7zZOvuvU5GV7IcE3ujOqQDyrxh5OF
         2tKVpa07WMJAt/r04x0uSVjRYG/3/8/YxM86R4kOC61TUGpDX2gd/BvCKPTzRp/pob+Q
         1cyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H3EJuqeRE2ICIwkh8UfM3ZgpmiaT2NjwHfTW5cfwv8w=;
        fh=ERG9IYAYxoFdxIeOGlWMLk9M5kiu2hnJugA1aUCqQMM=;
        b=XSZooWjBHtF9/dNQ/ctKOzwsg92/Qx/+QwsV8DQRLfWf7bMZc4f3DPYX8WUm1iVhWf
         rBQaicjjdZ4AhqUJp8b0FzM6tu8iPtN4Nf5cKoSpg/fk4jfULzwdvPQMCCkwLWSYyIxA
         EsZ6UxF/cBRjAi35K8W39Sxctj7pAY55o7w0Q3ECSmHB6EmqvrlnNJm5OYtbsdDq5Lnl
         MJqH6NT2bB9iYSAHZ3tZBV5BJFq2Io1ss0Vkyx4faG0xw6CQUyVd0p/eIunlOL/nGgSr
         ok7uAm36LbSfOz2G48w5YeMZnfBLyB5SFTHY08lFVzAF/VTWUDU0bxoVifuvI/0oVdve
         KEMw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795626818; x=1796231618; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H3EJuqeRE2ICIwkh8UfM3ZgpmiaT2NjwHfTW5cfwv8w=;
        b=c4m7kfKIfzKWHNYTrwaWFB5Vi/+9oevjo0V7MdGY6M24bclr11/Mp1z+SOOnb1HLwW
         g91dosRLde7vkV6Q9L0jY1KOpis/NO6oKnzOA3N3jVvGIhs+w4z2obnYISPW/x98l0iU
         M23ES91lLuUfrMYkJS601V/wGP744N0XwhVomDdpWHxA0ZJRs6pinzRnrGLgxdYuWstH
         5ot6oygkZLZ/emKs7sewC8AA8Oy0enZz1n98rV/yDJtuR8lQybp/MI7aRe0qcvFBc2+n
         wHSPq9SVcKaUk59D0qBpIA5cbi2W4nB3vprXXF4zJ/HXD3MCQ6MT7VjHWT3CQixMIxYa
         PWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795626818; x=1796231618;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H3EJuqeRE2ICIwkh8UfM3ZgpmiaT2NjwHfTW5cfwv8w=;
        b=vS3wGT9zWLgKSc8naY4iDmvA4HBYs631kvWDkVdW7Fxzw7SM7UoSoLKamug8gKhQQa
         tMmwmvnfMeULpJ4tarVNBbBh9AJJujAJr6MrCRq/0KSw+/4cexf9SO9wntA5QxoWqz6u
         9e0VBCVCTuFGZsi5v0ZXVU1fKU5dNpiKn6zgPnQSuDIEqWIyong3xR8hRhohq+NeGSt0
         pn1FCY+BKQDjx+0ClnVZW26CEoKzPw4OfUslib/I5CFGQWzyeC1uTLKSSsPNJcIyAl1Q
         Se7Oa9CbHtKDipOKVSJDhsx0Hg8ZZzqJbco3EtsyYeKhP6DBDrvTjxLK4i+2Eb9TAztd
         NpOA==
X-Gm-Message-State: APuU4Z89WkNd1LhswJSuDRbQ5YKqnCTv+klpFxA8NtEWux4YNysIzbWX
	NBDPsI3CfkkLnsTmlK8oIIqzS4duEvYXNDTPABBsNDbgUBybAj7CrY0qyV+TBQfSw5wLhGPplee
	KcS1/qDzx+xkYdLeTYOVicdpso5Vc9v87xwN5qUM=
X-Gm-Gg: AZFdTZdbQ69FeqFeAaWVRjQB39ZCdWAhbs5uYn/MFHUqkGGrtK+OdSHtDgPjunPEBX9
	au4zywat5rtE4wDjcztQlJlmKrsYabOpj9oKKzoBYwHov5PHS+qCfw81pRzOH/skcg7w9bLkdDB
	P5jfri1p/GpH7tTq9nLHpSv1eEKOcSeMVT5j/WKXD5ES84fyc8QOCZEWV04u8VBQN4OXvMaqfcC
	oHqXTPKAYq+FhXtfhaCXyO9bzR0XDa0tV55/RXdJD0FFz95Z0HcHqmdBYE6+DGt9g8y2aXBVGPz
	DIWhC6Q+E/UiiThwTMxU/RjiHB4+L3Ej3KIScy5iQDPou36KslIvuBASoqOXQiPyKhTbxT9R9p4
	e+mevP1fcfA9dHTVvOPTqZxZAxF5ST8pBB9dQMfnFltYzaSa8SX072RkXJtHmC5xPUH7tXvRHa1
	9Q3UxUZN35RGAbWxgVBrdxBJ+3n01VrtV0KY22pALeFllXk5hrh2o6HiE2u2OA+bu0V10pPPoaY
	Pg61HeXOdAtPm1GINA=
X-Received: by 2002:a17:906:26c5:b0:c51:3b84:6fb8 with SMTP id
 a640c23a62f3a-c513b84886cmr1351892666b.4.1795626818164; Wed, 25 Nov 2026
 09:13:38 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAPM+r-Jaz9c0d1F3QP_5aZDnRMGVmzWDrp-FMUcvUv5e2RpB_g@mail.gmail.com>
 <2a8cbf32-4fd3-4aaf-87dd-6a2a7638f6c9@cambridgegreys.com>
In-Reply-To: <2a8cbf32-4fd3-4aaf-87dd-6a2a7638f6c9@cambridgegreys.com>
From: Johan ter Mors <johan.termors@gmail.com>
Date: Wed, 25 Nov 2026 18:13:26 +0100
X-Gm-Features: Aa3M54p6SBxD_LLR7oAFXrJrJDdPSgmS2eWBfpn6LLXInZc6lKm63nqrn2BuULc
Message-ID: <CAPM+r-LBa7SOajvMb+qZAjN7vPCH+MVj-GpSiRBbFqo+KkuTOg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_UML=3A_=2Fproc=2Fnet=2Fnetstat_silently_mis=2Dread_by_stdi?=
	=?UTF-8?Q?o_line_readers_=28fgets=2Fgetline=29_=E2=80=94_raw_reads_of_every_size_a?=
	=?UTF-8?Q?re_byte=2Dexact=2C_all_other_=2Fproc_files_are_unaffected?=
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org, richard@nod.at, johannes@sipsolutions.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261125_091342_373247_83FE6D04 
X-CRM114-Status: GOOD (  38.45  )
X-Spam-Score: -2.1 (--)
X-Mailman-Approved-At: Thu, 26 Nov 2026 08:04:14 -0800
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
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Anton,

Yes =E2=80=94 reproduced on a build without multipath TCP.

Config: the same lean 7.3.6 build as in the report, with only CONFIG_MPTCP
(and MPTCP_IPV6) turned off; everything else identical (defconfig + HOSTFS/
BLK_DEV_INITRD/RD_GZIP/VETH/NET_NS/SYN_COOKIES/IPV6, DEBUG_INFO/BTF off,
the same two ptrace-only lab patches that do not touch procfs).
Guest-side proof that this is really a no-MPTCP kernel: the raw
/proc/net/netstat is 2748 bytes here vs 4197 on the MPTCP control build,
and the MPTcpExt records are absent from the raw dump. Control kernel:
same recipe with MPTCP on. Kernel hash:

  no-MPTCP  vmlinux sha256
ead23a1013670c33afedb70fa57129c6ed803f84393acf97e8c640b8ce4e3dd8
  control   the report build (vmlinux_736_e736_saved)

Method: per kernel, 160 fresh process instances across two boots =E2=80=94 =
each
boot runs 40 execve'd instances of a static glibc instrument that does the
full pattern set against a raw-read reference of the same boot, plus 40
instances of the literal minimal reproducer from my report (same C code,
only the printf gained an instance id), plus 40 fork-cloned instances.
One variable between the two kernels: CONFIG_MPTCP.

  pattern (diag instrument, 80 fresh execs per kernel, 2 boots)
                        no-MPTCP       MPTCP control
  fgets(buf, 16384)     80/80 corrupt  80/80 corrupt
  fgets(buf, 4096)      80/80 exact    80/80 exact
  getline()             80/80 exact    80/80 exact
  fread(buf, 16384)     80/80 exact    80/80 exact
  raw read(fd, 131072)  80/80 exact    80/80 exact

  literal report reproducer, 40 instances per kernel:
    no-MPTCP        first-line=3D1025 total=3D1577 names=3Dyes  (40/40)
    MPTCP control   first-line=3D1025 total=3D3026 names=3Dyes  (40/40)

The corruption is identical in shape and size on both kernels: the first
fgets(16384) returns 1025 bytes of the 2196-byte TcpExt names line, the
remaining 1171 bytes of that line never appear in the stream, everything
after it is byte-exact (assembled total 1577 of 2748 without MPTCP, 3026
of 4197 with =E2=80=94 the same absolute 1171 bytes lost). (In this shape t=
he
surviving 1025 bytes still contain "SyncookiesSent", hence names=3Dyes
despite the loss =E2=80=94 flag semantics, not a contradiction with the rep=
ort's
names=3DNO captures.) The only kernel-side difference is the file's own
MPTcpExt lines; the loss is a function of the reader, not of the content.

Two honest refinements, stated explicitly:

1. Within a boot, the behaviour is fully deterministic: all 160 instances
per kernel =E2=80=94 across both boots, both instruments and the fork-clone=
d runs
=E2=80=94 fail identically (same call, same lost chunk). The shapes we repo=
rted
in the original mail (first byte fused onto the next record; and the
full-length stream with stale-memory windows) are not what the same
reproducer shows on these fresh boots: today it is the 1025-byte
truncation shape above. So the *shape* of the mis-assembly tracks the
reader context / boot session, not the kernel configuration =E2=80=94 both
kernels show exactly the same shape today.

2. The failure mode is a function of the reader's layout/state; we still
cannot split the mechanism further from user space, and the raw path
remains byte-exact everywhere (all other /proc files clean under all
patterns, as reported).

We have no non-UML kernel >=3D 6.12 here (no hypervisor), so the stock-kern=
el
control stays open =E2=80=94 if it helps, the test binary is one small stat=
ic
file; we can send it (plus the diag sources and serial logs) and you can
run it on any UML and any regular 6.12/7.x box in seconds.

Happy to test hypotheses or patches.

Kind regards,
Johan ter Mors

Op wo 25 nov 2026 om 17:30 schreef Anton Ivanov
<anton.ivanov@cambridgegreys.com>:
>
>
>
> On 25/11/2026 16:24, Johan ter Mors wrote:
> > [Quick note before the report: my earlier mail of today carried a
> > mangled Subject header =E2=80=94 my mail client put the intended mainta=
iner
> > Cc addresses into the subject line, so the report went out without a
> > usable subject and without the maintainer Cc. This thread is the same
> > report with a corrected envelope; please treat this copy as the
> > report. The mangled original is archived here, for the record:
> >
> > https://lore.kernel.org/linux-um/CAPM+r-+XCeM01ZXAj8Cti5qL1iaFrGrV+dYSu=
mWD8585O3swew@mail.gmail.com/
> > ]
> >
> > Hi,
> >
> > While parsing TcpExt counters inside our lab guests (own lean UML
> > builds), we hit a reproducible case where stdio line readers (fgets
> > and getline) silently mis-read /proc/net/netstat =E2=80=94 while every =
raw
> > read of the same file, on the same boot, is byte-exact. The same
> > statically linked binary behaves correctly on a non-UML host kernel.
> > We have not found an earlier report, so here is the full picture. We
> > could not pin the final mechanism; the data is attached so you can
> > judge it directly.
> >
> > Observed:
> >
> >    - Which stdio call mis-assembles varies per process instance of the
> >      same binary; within one instance it is deterministic per fopen.
> >      Captured byte-exactly across instances on 7.3.6 and 6.12.117:
> >        * fgets(buf, 16384) mis-assembles in most instances. Two shapes:
> >            (i) the TcpExt *names* record is lost except its first byte,
> >                which fuses onto the next record: the stream starts
> >                "TTcpExt: 0 0 ...". 2002 of 4197 bytes on 7.3.6; 1718 of
> >                3862 on 6.12.117 =E2=80=94 exactly the names-line length=
 is
> >                missing, and memcmp proves the output is the pure
> >                subsequence "T" + rest-of-file;
> >            (ii) full-length output (4197/4197) in which the names
> >                string is absent and 16-byte windows exist that appear
> >                NOWHERE in the file =E2=80=94 the reader's own stale pro=
cess
> >                memory mixed into the assembled stream.
> >        * In other instances fgets(buf, 4096) mis-assembled (names-line
> >          length missing, plus foreign windows) while fgets(buf, 16384)
> >          was byte-exact in the same process; in another instance
> >          getline() returned full-length output with foreign windows.
> >          So no fgets size is a safe workaround.
> >        * Three fresh fopen() repeats of fgets(16384) in one instance
> >          where the earlier calls were all byte-exact stayed correct =E2=
=80=94
> >          but we have not seen a rule predicting which instance fails.
> >    - Scope sweep, both UML kernels: 20 /proc files (net/netstat, snmp,
> >      dev, sockstat, softnet_stat, tcp, udp, unix, mounts, cpuinfo,
> >      version, self/limits, self/status, vmstat, meminfo, stat, uptime,
> >      loadavg, ...) x 6 reader patterns (getline, fgets 512/4096/16384/
> >      65536, fread 16384): every file reads byte-exact with every
> >      pattern EXCEPT /proc/net/netstat.
> >    - fread(buf, 16384) and explicit setvbuf() configurations (4096/
> >      8192/16384-byte buffers, _IONBF, _IOLBF) have so far never
> >      mis-assembled (limited number of instances observed), and raw
> >      read() is byte-exact in every pattern we tried: single reads of
> >      18 sizes (2048 .. 131072) at offset 0, sequential pairs, and
> >      lseek(K)+read() sweeps across the record boundaries =E2=80=94 on t=
he same
> >      boots where stdio mis-assembles.
> >    - The identical binary on a non-UML host kernel (5.10.134) is
> >      correct for every pattern in every instance.
> >    - Reproduces on 6.12.117, 7.3.5 and 7.3.6 UML (own lean builds;
> >      defconfig + MPTCP/HOSTFS/BLK_DEV_INITRD/RD_GZIP/VETH/NET_NS, and
> >      SYN_COOKIES/IPV6 on 7.3.6; DEBUG_INFO/BTF off; two small
> >      ptrace-only lab patches that do not touch procfs).
> >    - We do not have a non-UML kernel >=3D 6.12 in this lab (no
> >      hypervisor), so a stock-kernel control is still open =E2=80=94 run=
ning the
> >      reproducer on any regular 6.12/7.x box would pin the scope nicely.
> >
> > Security note: we checked this explicitly before reporting. The
> > mis-assembled output contains only file bytes plus, in the mixing
> > shape, the reader's own stale process memory =E2=80=94 never anything o=
utside
> > the reading process (the kernel's raw read path is byte-exact on the
> > same boots, verified down to writes into stack buffers; memcmp
> > controls prove the file content was stable). No crash, no splat, no
> > privilege effect in any run; the reader is its own only victim. So we
> > do not consider this a security issue =E2=80=94 it is a correctness bug=
 for
> > common parsing patterns, and monitoring agents parsing
> > /proc/net/netstat with stdio on UML silently lose the TcpExt field
> > names.
> >
> > Minimal reproducer (static glibc, reads the file, prints three
> > numbers):
> >
> > #define _GNU_SOURCE
> > #include <stdio.h>
> > #include <string.h>
> > int main(void) {
> >      FILE *f =3D fopen("/proc/net/netstat", "r");
> >      static char line[16384], all[65536];
> >      int tot =3D 0, l1 =3D -1;
> >      while (fgets(line, sizeof line, f)) {
> >          int n =3D (int)strlen(line);
> >          if (l1 < 0) l1 =3D n;
> >          if (tot + n < (int)sizeof all) { memcpy(all + tot, line, n); t=
ot +=3D n; }
> >      }
> >      printf("first-line=3D%d total=3D%d names=3D%s\n", l1, tot,
> >             tot > 0 && memmem(all, tot, "SyncookiesSent", 14) ? "yes" :=
 "NO");
> >      return 0;
> > }
> >
> > On UML 7.3.6, failing instance A:  first-line=3D1 total=3D2002 names=3D=
NO
> >                                     (names lost, fused)
> > On UML 7.3.6, failing instance B:  first-line=3D2196 total=3D4197 names=
=3DNO
> >                                     (full length, stale-memory mixing)
> > Correct instance of the same binary on the same guest:
> >                                     first-line=3D2196 total=3D4197 name=
s=3Dyes
> >
> > Because every raw read of the same file is correct on the same boots,
> > we suspect the fault sits in the interaction between the UML
> > syscall-return delivery and glibc stdio's line assembly rather than in
> > seq_file's data path; the per-instance randomness (same binary, same
> > pattern, byte-exact in one instance and mis-assembled in the next)
> > suggests the failure depends on the reader process's layout/state. We
> > cannot split that further from user space, and a ptrace-based tracer
> > on UML is not a reliable witness (the guest kernel already ptraces its
> > own user processes for syscall emulation, so a second ptrace layer
> > distorts what it observes).
> >
> > Kernel log clean on all runs; happy to provide the full diagnostic
> > sources, serial logs and the saved UML vmlinux files, and to test
> > patches or hypotheses.
> >
> > Thanks,
> > Johan ter Mors =E2=80=94 independent researcher
> >
> >
>
> I have never observed this. Quick question - can you reproduce it with a =
kernel build without multipath TCP?
>
> --
> Anton R. Ivanov
> Cambridgegreys Limited. Registered in England. Company Number 10273661

