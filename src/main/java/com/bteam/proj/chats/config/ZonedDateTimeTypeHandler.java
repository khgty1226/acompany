package com.bteam.proj.chats.config;

import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.Instant;
import java.time.ZoneId;
import java.time.ZonedDateTime;

public class ZonedDateTimeTypeHandler extends BaseTypeHandler<ZonedDateTime> {
    @Override
    public void setNonNullParameter(PreparedStatement ps, int i, ZonedDateTime parameter, JdbcType jdbcType) throws SQLException {
        Instant instant = parameter.toInstant();
        ps.setTimestamp(i, Timestamp.from(instant));
    }

    @Override
    public ZonedDateTime getNullableResult(ResultSet rs, String columnName) throws SQLException {
        Timestamp timestamp = rs.getTimestamp(columnName);
        return timestamp != null ? ZonedDateTime.ofInstant(timestamp.toInstant(), ZoneId.systemDefault()) : null;
    }

    @Override
    public ZonedDateTime getNullableResult(ResultSet rs, int columnIndex) throws SQLException {
        Timestamp timestamp = rs.getTimestamp(columnIndex);
        return timestamp != null ? ZonedDateTime.ofInstant(timestamp.toInstant(), ZoneId.systemDefault()) : null;
    }

    @Override
    public ZonedDateTime getNullableResult(CallableStatement cs, int columnIndex) throws SQLException {
        Timestamp timestamp = cs.getTimestamp(columnIndex);
        return timestamp != null ? ZonedDateTime.ofInstant(timestamp.toInstant(), ZoneId.systemDefault()) : null;
    }
}
